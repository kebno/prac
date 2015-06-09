module simpleDBSS

function computesimpledbss(f,zs; v=5, rcpa=2000,tcpa=45,sim_dur=90,doppler=true)
# simpleDBSS
# 2014, John Boyle - NEAR-Lab, Portland State University
# May 2014, John Boyle (Julia Implementation)
#
# Demonstration of the depth transform, or depth-based signal separation
#    INPUTS  f 	     source frequency
#			 zs      source depth (positive z is down)
#			 v       source velocity
#            rcpa    surface range (meters) of closet point of approach
#            tcpa    time (minutes) of CPA
#            sim_dur duration of simulation (minutes)
#            doppler toggle simple doppler calculation (as if you tracked
#                    target signal in frequency, but computed depth
#                    transform at original source frequency)
#
#    OUTPUT  VTR     VTR PlotData object
#            TRACE   target trace signal PlotData object
#            DBSS    depth transform result PlotData object
#
# Computes the pressure field of a submerged point source in an isovelocity ocean
# by image theory. A delay-and-sum beamformer is applied to
# the computed pressure values on a vertical line array to give a
# vertical-angle/time record (VTR) that shows the spatial distribution
# of the received acoutic intensity on the VLA.  The vertical angle of
# the beamformer output on the VTR is expressed as the sine of the
# vertical angle rather that in degrees.
#
# The vertical angle convention for this simulation is that sin(theta)=+1
# is vertical, sin(theta)=0 is horizontal, and sin(theta)=-1 is down.
#
# This function returns a VTR object and a DBSS object containing the
# results of the calculation.

	# Sim. Parameters
	SL = 110                  # source level
	Lsnap = 4                 # Snapshot length (seconds)
	t = [0 : Lsnap/60 : sim_dur]*60 # time vector (seconds)

	c = 1500                  # sound speed (m/s)
	k = 2*pi*f/c              # harmonic wavenumber
	lambda = c/f              # wavelength

	Nst = 50                 # Number of VTR beams
	st = linspace(0, 1, Nst) # angular range for VTR

	# VLA
	N = 15                    # number elements
	design_f = 333.33         # array design frequency
	d = 2.25                  # array element spacing
	arrayZ = 4990 .- [1:N].'*d   # array depths (m)
	zBar = mean(arrayZ)       # mean array depth

	## Target track
	surf_range = sqrt(rcpa^2 .+ ((t.-tcpa*60) * v).^2) # surface range to source from VLA
	target_track = zBar./sqrt(zBar^2.+surf_range.^2) # sin(theta) to surface location of target
	dtarget_track = diff(target_track)
	dtarget_track = [dtarget_track[1], dtarget_track].'

	# relative velocity between array and source
	v_rel = v^2 * (t.-tcpa*60) ./ sqrt(surf_range.^2 .+ zBar^2)

	## Doppler calculation
	if doppler
		f_dop = (1 .+ v_rel/c) .* f
	else
		f_dop = f
	end

	## Pressure Field
	slantrange(r,z) = sqrt(r.^2 + z.^2)
	Rimage = broadcast(slantrange,surf_range,arrayZ.+zs)     # image source
	Rsource = broadcast(slantrange,surf_range,arrayZ.-zs)    # real source

	x = (10^(SL/20)                             # field at phones
		* (exp(im*2*pi*(f_dop/c).*Rsource) ./ Rsource
		- exp(im*2*pi*(f_dop/c).*Rimage) ./ Rimage))

	# Beamformer function
	# note: unlike matlab, [1:N] creates a column vector
	beamweights(sintheta) = exp(-im * k*-([1:N] .- N/2) * d .* sintheta.') ./ sqrt(N)

	# VTR Beamformer
	w = beamweights(st)

	vtr_data = w.' * x.'

	# Create VTR PlotData object
	vtr = PlotData(vtr_data,t,st,"linear")

	## Target beamformer
	# NOTE: 'w' matrix is now "phones X target_track vals over time"
	#   Each set of array weights is for the different sintheta value
	#   at each snapshot. Thus we sum along the first dimension (columns)
	# P is the exact trace signal
	w = beamweights(target_track)
	P = w .* x.'
	P = abs(sum(P,1)).^2

	# Create TRACE PlotData object
	trace = PlotData(squeeze(P,1),target_track,t,"linear")

	# Analytic beamformer output expression
	P_an = N*2*(10^(SL/20))^2/zBar^2*target_track.^2 .* (1.-cos(2*k*zs*target_track))

	## Depth Transform and Inverse Depth transform
	zmin = -200
	zmax = 200
	z = linspace(zmin,zmax,length(target_track))
  M = depthtransform_dft(P.*abs(dtarget_track),k,z.',target_track.')

	# Create DBSS object
	dbss = PlotData(M,z,z,"linear")

    return vtr,trace,dbss
end

type PlotData
  data::Array
  xaxis::Array
  yaxis::Array
  datascale::String
end

function depthtransform_dft(P,k,z,track_st)
#DEPTHTRANSFORM_DFT A modified DFT for depth transform.
# Returns linear scale, transform output
#   P:        the signal to transform
#   k:        source wavenumber
#   track_st: target track in sinTheta
#   z:        depth vector for evaluation
#
# Apr 2014, John Boyle - NEAR-Lab Portland State University
        M = fill(0.0+im*0.0,size(track_st))
        for ii = 1:length(z)
                M[ii] = sum(P .* exp(-im*2*k*z[ii] .* track_st))
	end
	return squeeze(M,1)
end

function depthtransform_idft(M,k,z,track_st)
#DEPTHTRANSFORM_IDFT A modified IDFT for depth transform.
# Returns linear scale transform output
#   M:        the signal to transform
#   k:        wavenumber for the source frequency
#   track_st: target track in sin\theta
#   z:        depth vector for evaluation
#
# Apr 2014, John Boyle - NEAR-Lab Portland State University
	P = 0
	N = length(track_st)

	for ii = 1:N
		P[ii] = 1/(2*pi*N)*sum(M .* exp(1i*2*k*z * track_st(ii)))
	end
	return squeeze(P,1)
end

###########################################################################
using PyPlot

vtr,trace,dbss = @time(computesimpledbss(150,75;tcpa=30,sim_dur=60))

line_data = 10*log10(abs(dbss.data))
figure()
plot(dbss.xaxis,line_data-maximum(line_data))
title("Depth Transform Output")
xlabel("Depth (m)")
ylabel("Normalized dB")

line_data = 10*log10(abs(trace.data))
figure()
plot(trace.xaxis,line_data-maximum(line_data))
title("Target Trace Signal")
xlabel("Track Distance (km)")
ylabel("Normalized dB")
ylim(-20,0)

end
