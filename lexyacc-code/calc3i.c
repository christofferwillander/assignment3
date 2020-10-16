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
        printf("\tpush\t$%d\n", p->con.value);
        break;
    case typeId:        
        printf("\tpush\t%c\n", p->id.i + 'a'); 
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
            printf("\tmovq\t$formatString, %%rdi\n");
            printf("\tpop\t%%rsi\n");
            printf("\txor\t%%rax, %%rax\n");
            printf("\tcall\tprintf\n");
            break;
        case '=':       
            ex(p->opr.op[1]);
            printf("\tpop\t%c\n", p->opr.op[0]->id.i + 'a');
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tneg\n");
            break;
	case FACT:
  	    ex(p->opr.op[0]);
	    printf("\tfact\n");
	    break;
	case LNTWO:
	    ex(p->opr.op[0]);
	    printf("\tlntwo\n");
	    break;
        default:
            ex(p->opr.op[0]);
            ex(p->opr.op[1]);
            switch(p->opr.oper) {
                case GCD:
                    printf("\tpop\t%%rdi\n");
                    printf("\tpop\t%%rsi\n");
                    printf("\tcall\tgcd\n"); 
                    printf("\tpush\t%%rax\n");
                    break;
                case '+':
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");   
                    printf("\tadd\t%%r8, %%r9\n"); 
                    printf("\tpush\t%%r9\n");
                    break;
                case '-':   
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");   
                    printf("\tsub\t%%r8, %%r9\n");
                    printf("\tpush\t%%r9\n");  
                    break; 
                case '*':
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");   
                    printf("\timul\t%%r8, %%r9\n");
                    printf("\tpush\t%%r9\n"); 
                    break;
                case '/':   
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");   
                    printf("\tdivs\t%%r8, %%r9\n");
                    printf("\tpush\t%%r9\n");
                    break;
                case '<':   
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");
                    printf("\tcmp\t%%r8, %%r9\n");
                    printf("\tjge\tL%03d\n", lbl2 = lbl);
                    break;
                case '>':   
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");
                    printf("\tcmp\t%%r8, %%r9\n");
                    printf("\tjle\tL%03d\n", lbl2 = lbl);
                    break;
                case GE:    
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");
                    printf("\tcmp\t%%r8, %%r9\n");
                    printf("\tjl\tL%03d\n", lbl2 = lbl);
                    break;
                case LE:    
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");
                    printf("\tcmp\t%%r8, %%r9\n");
                    printf("\tjg\tL%03d\n", lbl2 = lbl); 
                    break;
                case NE:    
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");
                    printf("\tcmp\t%%r8, %%r9\n");
                    printf("\tjz\tL%03d\n", lbl2 = lbl);
                    break;
                case EQ:    
                    printf("\tpop\t%%r8\n");
                    printf("\tpop\t%%r9\n");
                    printf("\tcmp\t%%r8, %%r9\n");
                    printf("\tjne\tL%03d\n", lbl2 = lbl);
                    break;
            }
        }
    }
    return 0;
}
