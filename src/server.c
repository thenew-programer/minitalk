/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ybouryal <ybouryal@student.1337.ma>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/21 17:15:41 by ybouryal          #+#    #+#             */
/*   Updated: 2025/02/21 18:25:29 by ybouryal         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	talk(int sig, siginfo_t *info, void *context)
{
	static sig_atomic_t	byte;
	static sig_atomic_t	counter;
	static sig_atomic_t	client_pid;

	(void)context;
	if (client_pid != info->si_pid)
	{
		byte = 0;
		counter = 0;
	}
	byte = byte << 1;
	if (sig == SIGUSR1)
		byte |= 1;
	counter++;
	if (counter == 8)
	{
		if (byte == 0)
			ft_putchar_fd(10, 1);
		else
			ft_putchar_fd(byte, 1);
		byte = 0;
		counter = 0;
	}
	kill(info->si_pid, SIGUSR1);
	client_pid = info->si_pid;
}

int	main(void)
{
	struct sigaction	sa;
	int					pid;
	char				*tmp;

	sa.sa_sigaction = talk;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	pid = getpid();
	tmp = ft_itoa(pid);
	ft_putendl_fd("Use the pid below if you want to comunicate.", 1);
	ft_putstr_fd("Server PID => ", 1);
	ft_putendl_fd(tmp, 1);
	free(tmp);
	while (1)
		pause();
}
