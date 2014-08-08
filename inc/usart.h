#ifndef USART_H
#define USART_H 1

#include <stm32f4xx.h>

void init_USART1(uint32_t baudrate);
void init_USART6(uint32_t baudrate);
void USART_puts(USART_TypeDef* USARTx, volatile char *s);

#endif /* USART_H */
