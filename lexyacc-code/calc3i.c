#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"

static int lbl;

int ex(nodeType *p) {
    int lbl1, lbl2;

    if (!p) return 0;
    switch(p->type) {
    case typeCon:       
        printf("\tpushq\t$%d\n", p->con.value);
        break;
    case typeId:        
        printf("\tpushq\t%c\n", p->id.i + 'a'); 
        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);
            ex(p->opr.op[0]);
            lbl2 = lbl++;
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                lbl1 = lbl++;
                ex(p->opr.op[1]);
                printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                printf("L%03d:\n", lbl1);
                ex(p->opr.op[2]);
                printf("L%03d:\n", lbl2);
            } else {
                /* if */
                lbl1 = lbl++;
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl1);
            }
            break;
        case PRINT:     
            ex(p->opr.op[0]);
            printf("\tpopq\t%%rsi\n");
            printf("\tleaq\tformatString, %%rdi\n");
            printf("\txorq\t%%rax, %%rax\n");
            printf("\tcall\tprintf\n");
            break;
        case '=':       
            ex(p->opr.op[1]);
            printf("\tpopq\t%c\n", p->opr.op[0]->id.i + 'a');
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tpopq\t%%r8\n");
            printf("\tnegq\t%%r8\n");
            printf("\tpushq\t%%r8\n");
            break;
	case FACT:
  	    ex(p->opr.op[0]);
	    printf("\tpopq\t%%rdi\n");
	    printf("\tcall\tfact\n");
        printf("\tpushq\t%%rax\n");
	    break;
	case LNTWO:
	    ex(p->opr.op[0]);
        printf("\tpopq\t%%rdi\n");
	    printf("\tcall\tlntwo\n");
        printf("\tpushq\t%%rax\n");
	    break;
        default:
            ex(p->opr.op[0]);
            ex(p->opr.op[1]);
            switch(p->opr.oper) {
                case GCD:
                    printf("\tpopq\t%%rdi\n");
                    printf("\tpopq\t%%rsi\n");
                    printf("\tcall\tgcd\n"); 
                    printf("\tpushq\t%%rax\n");
                    break;
                case '+':
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");   
                    printf("\taddq\t%%r8, %%r9\n"); 
                    printf("\tpushq\t%%r9\n");
                    break;
                case '-':   
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");   
                    printf("\tsubq\t%%r8, %%r9\n");
                    printf("\tpushq\t%%r9\n");  
                    break; 
                case '*':
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");   
                    printf("\timulq\t%%r8, %%r9\n");
                    printf("\tpushq\t%%r9\n"); 
                    break;
                case '/':
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%rax\n");
                    printf("\tcqto\n");
                    printf("\tidivq\t%%r8\n");
                    printf("\tpushq\t%%rax\n");
                    break;
                case '<':   
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");
                    printf("\tcmpq\t%%r8, %%r9\n");
                    printf("\tjge\tL%03d\n", lbl2 = lbl);
                    break;
                case '>':   
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");
                    printf("\tcmpq\t%%r8, %%r9\n");
                    printf("\tjle\tL%03d\n", lbl2 = lbl);
                    break;
                case GE:    
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");
                    printf("\tcmpq\t%%r8, %%r9\n");
                    printf("\tjl\tL%03d\n", lbl2 = lbl);
                    break;
                case LE:    
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");
                    printf("\tcmpq\t%%r8, %%r9\n");
                    printf("\tjg\tL%03d\n", lbl2 = lbl); 
                    break;
                case NE:    
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");
                    printf("\tcmpq\t%%r8, %%r9\n");
                    printf("\tjz\tL%03d\n", lbl2 = lbl);
                    break;
                case EQ:    
                    printf("\tpopq\t%%r8\n");
                    printf("\tpopq\t%%r9\n");
                    printf("\tcmpq\t%%r8, %%r9\n");
                    printf("\tjne\tL%03d\n", lbl2 = lbl);
                    break;
            }
        }
    }
    return 0;
}
