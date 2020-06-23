*&---------------------------------------------------------------------*
*& Report ZSS_CURRENY_DECIMAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zss_curreny_decimal.

DATA : lv_dcpfm TYPE usr01-dcpfm.
DATA : lv_amount_curr TYPE bseg-nebtr.
DATA : lv_amount(10).

SELECT SINGLE nebtr FROM bseg INTO lv_amount_curr WHERE nebtr > 100000.

lv_amount = lv_amount_curr.
SELECT SINGLE dcpfm FROM usr01 INTO lv_dcpfm WHERE bname EQ sy-uname.
IF lv_dcpfm EQ 'X'.
  REPLACE ALL OCCURRENCES OF ',' IN lv_amount WITH ''.
  TRANSLATE lv_amount USING ','.
ELSEIF lv_dcpfm EQ ''.
  REPLACE ALL OCCURRENCES OF '.' IN: lv_amount WITH ''.
  TRANSLATE lv_amount USING '.'.
ELSEIF lv_dcpfm EQ 'Y'.
  REPLACE ALL OCCURRENCES OF ' ' IN lv_amount WITH ''.
  TRANSLATE lv_amount USING ''.
ENDIF.

BREAK samburi.
WRITE : / lv_amount.
