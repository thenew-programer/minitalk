/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ybouryal <ybouryal@student.1337.ma>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/21 18:00:51 by ybouryal          #+#    #+#             */
/*   Updated: 2025/02/21 18:14:02 by ybouryal         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

volatile sig_atomic_t	g_ack_received = 0;

void	die(char *msg)
{
	ft_putendl_fd(msg, 2);
	exit(1);
}

void	send(int pid, t_byte byte)
{
	int	i;

	i = 1 << 7;
	while (i)
	{
		if (byte & i)
		{
			if (kill(pid, SIGUSR1) == -1)
				die("No such process");
		}
		else
		{
			if (kill(pid, SIGUSR2) == -1)
				die("No such process");
		}
		while (!g_ack_received)
			;
		g_ack_received = 0;
		i >>= 1;
	}
}

void	talk(char *s_pid, char *msg)
{
	int	pid;
	int	i;

	pid = ft_atoi(s_pid);
	if (pid == 0)
		die("Bad pid");
	i = 0;
	while (msg[i])
		send(pid, msg[i++]);
	send(pid, msg[i]);
}

void	handler(int sig)
{
	if (sig == SIGUSR1)
		g_ack_received = 1;
}

int	main(int ac, char **av)
{
	if (ac != 3)
		die("usage: ./client <server-pid> <message>");
	signal(SIGUSR1, handler);
	talk(av[1], av[2]);
	return (0);
}
