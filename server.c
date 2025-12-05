/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kaidda-s <kaidda-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/28 15:43:06 by kaidda-s          #+#    #+#             */
/*   Updated: 2025/12/01 22:37:43 by kaidda-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	handle_signal(int sig)
{
	static int	bit;
	static int	c;

	if (sig == SIGUSR1)
		c |= (0 << bit);
	else if (sig == SIGUSR2)
		c |= (1 << bit);
	bit++;
	if (bit == 8)
	{
		if (c == 0)
			ft_printf("\n");
		else
			ft_printf("%c", c);
		bit = 0;
		c = 0;
	}
}

void	setup_signals(void)
{
	signal(SIGUSR1, handle_signal);
	signal(SIGUSR2, handle_signal);
}

int	main(void)
{
	pid_t	pid;

	pid = getpid();
	ft_printf("Server PID: %d\n", pid);
	ft_printf("Waiting for messages...\n");
	setup_signals();
	while (1)
		pause();
	return (0);
}
