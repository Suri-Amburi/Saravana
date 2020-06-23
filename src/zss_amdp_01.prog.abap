*&---------------------------------------------------------------------*
*& Report ZSS_AMDP_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_AMDP_01.

 IF not cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method )
                       ( cl_abap_dbfeatures=>amdp_table_function ) ) ).
      cl_demo_output=>display(
        'System does not support AMDP or CDS table functions' ).
      RETURN.
    ENDIF.

    DATA carrid TYPE s_carr_id VALUE 'LH'.
    cl_demo_input=>request( CHANGING field = carrid ).
    carrid = to_upper( carrid ).

    "Database function selected in database procedure
    TRY.
        NEW cl_demo_amdp_functions_inpcl( )->select_get_scarr_spfli(
          EXPORTING clnt   = sy-mandt
                    carrid = carrid
          IMPORTING scarr_spfli_tab = DATA(result1) ).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.
