*&---------------------------------------------------------------------*
*& Report ZSS_FOR_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zss_for_loop.
TYPES : BEGIN OF ty_tab1,
          val1(5),
          val2     TYPE int2,
          val3(10),
          val4(10),
        END OF ty_tab1.

TYPES : BEGIN OF ty_tab2,
          val1(5),
          val6(10),
          val4(10),
        END OF ty_tab2.

DATA : lt_tab1  TYPE STANDARD TABLE OF ty_tab1,
       lt_tab2  TYPE STANDARD TABLE OF ty_tab2,
       lt_final TYPE STANDARD TABLE OF ty_tab1.

lt_tab1 = VALUE #(
                ( val1 = '123' val2 = 10 val3 = 'Test1' val4 = 'SS1' )
                ( val1 = '124' val2 = 11 val3 = 'Test3' val4 = 'SS1' )
                ( val1 = '125' val2 = 12 val3 = 'Test2' val4 = 'SS2' )
                ).

lt_tab2 = VALUE #(
                ( val1 = '123' val4 = 'SS1' val6 = 'This is 1 record from tab2' )
                ( val1 = '124' val4 = 'SS2' val6 = 'This is 2 record from tab2' )
                ( val1 = '125' val4 = 'SS2' val6 = 'This is 3 record from tab2' )
                ( val1 = '123' val4 = 'SS2' val6 = 'This is 4 record from tab2' )
                ).

BREAK samburi.
lt_final  = VALUE #( FOR ls_tab1 IN lt_tab1 FOR ls_tab2 IN lt_tab2  WHERE ( val1  = ls_tab1-val1 AND VAL4 = ls_tab1-val4 )
                     ( val1 = ls_tab1-val1
                       val2 = ls_tab1-val2
                       val3 = ls_tab2-val6 )
                   ).

cl_demo_output=>display( lt_final ).
BREAK samburi.
