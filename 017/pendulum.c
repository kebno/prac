/* A mash-up of the GLFW Getting Started program and the Rosetta Code "pendulum" example
*/

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include <sys/time.h>

#define length 5
#define g 9.8
double alpha, accl, omega = 0, E;
struct timeval tv;

static void error_callback(int error, const char* description)
{
    fputs(description, stderr);
}

static void key_callback(GLFWwindow * window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_ESCAPE && action == GLFW_RELEASE)
        glfwSetWindowShouldClose(window, GL_TRUE);
}

double elappsed() {
	struct timeval now;
	gettimeofday(&now, 0);
	int ret = (now.tv_sec - tv.tv_sec) * 1000000
		+ now.tv_usec - tv.tv_usec;
	tv = now;
	return ret / 1.e6;
}

void render()
{
	double x = 320 + 300 * sin(alpha), y = 300 * cos(alpha);
 	glClear(GL_COLOR_BUFFER_BIT);

	glBegin(GL_LINES);
	glVertex2d(320, 0);
	glVertex2d(x, y);
	glEnd();
	glFlush();

	double us = elappsed();
	alpha += (omega + us * accl / 2) * us;
	omega += accl * us;

	/* don't let precision error go out of hand */
	if (length * g * (1 - cos(alpha)) >= E) {
		alpha = (alpha < 0 ? -1 : 1) * acos(1 - E / length / g);
		omega = 0;
	}
	accl = -g / length * sin(alpha);

}

void resize(int width, int height) {
	glViewport(0, 0, width, height);
	glViewport(0, 0, width, height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glOrtho(0, width, height, 0, -1, 1);
}

int main(int c, char **v)
{
	alpha = 4 * atan2(1, 1) / 2.1;
	E = length * g * (1 - cos(alpha));

	accl = -g / length * sin(alpha);
	omega = 0;

	gettimeofday(&tv, 0);

	GLFWwindow* window;
	glfwSetErrorCallback(error_callback);
	if (!glfwInit())
		exit(EXIT_FAILURE);
	window = glfwCreateWindow(640, 480, "Simple example", NULL, NULL);
	if (!window)
	{
		glfwTerminate();
		exit(EXIT_FAILURE);
	}
	glfwMakeContextCurrent(window);
	glfwSwapInterval(1);
	glfwSetKeyCallback(window, key_callback);

	while (!glfwWindowShouldClose(window))
    {
        float ratio;
        int width, height;
        glfwGetFramebufferSize(window, &width, &height);
        ratio = width / (float) height;
		resize(width, height);

        render();
        glfwSwapBuffers(window);
        glfwPollEvents();
    }
    glfwDestroyWindow(window);
    glfwTerminate();
    exit(EXIT_SUCCESS);
}
