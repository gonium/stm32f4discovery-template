#include <stm32f4xx.h>
#include <misc.h>
#include "usart.h"

#define MAX_STRLEN 12 // this is the maximum string length of our string in characters
volatile char received_string[MAX_STRLEN+1]; // this will hold the received string

void Delay(__IO uint32_t nCount) {
  while(nCount--) {
  }
}

int main(void) {
  init_USART1(9600); 

	if (1) ;;
  USART_puts(USART1, "Hello 1World!\r\n"); // just send a message to indicate that it works

	if (1) ;;

  while (1){
    /*
     * You can do whatever you want in here 
     */
  }
}

//// this is the interrupt request handler (IRQ) for ALL USART1 interrupts
//void USART1_IRQHandler(void){
//	// check if the USART1 receive interrupt flag was set
//	if( USART_GetITStatus(USART1, USART_IT_RXNE) ){
//		static uint8_t cnt = 0; // this counter is used to determine the string length
//		char t = USART1->DR; // the character from the USART1 data register is saved in t
//		/* check if the received character is not the LF character (used to determine end of string) 
//		 * or the if the maximum string length has been been reached 
//		 */
//		if( (t != '\n') && (cnt < MAX_STRLEN) ){ 
//			received_string[cnt] = t;
//			cnt++;
//		}
//		else{ // otherwise reset the character counter and print the received string
//			cnt = 0;
//			USART_puts(USART1, received_string);
//			USART_puts(USART1, "\r\n");
//		}
//	}
//}
//
//// this is the interrupt request handler (IRQ) for ALL USART1 interrupts
//void USART6_IRQHandler(void){
//	// check if the USART6 receive interrupt flag was set
//	if( USART_GetITStatus(USART6, USART_IT_RXNE) ){
//		static uint8_t cnt = 0; // this counter is used to determine the string length
//		char t = USART6->DR; // the character from the USART6 data register is saved in t
//		/* check if the received character is not the LF character (used to determine end of string) 
//		 * or the if the maximum string length has been been reached 
//		 */
//		if( (t != '\n') && (cnt < MAX_STRLEN) ){ 
//			received_string[cnt] = t;
//			cnt++;
//		}
//		else{ // otherwise reset the character counter and print the received string
//			cnt = 0;
//			USART_puts(USART6, received_string);
//			USART_puts(USART6, "\r\n");
//		}
//	}
//}
