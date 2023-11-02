CLASS zcl_dummy_fullname_util DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! <p class="shorttext synchronized">Get ref/tag stack from full ref name</p>
    CLASS-METHODS get_parts
      IMPORTING
        full_name     TYPE string
      RETURNING
        VALUE(result) TYPE zif_dummy_ty_global=>ty_fullname_parts.

    "! <p class="shorttext synchronized">Return object with info of fullname</p>
    CLASS-METHODS get_info_obj
      IMPORTING
        full_name     TYPE string
      RETURNING
        VALUE(result) TYPE REF TO if_ris_abap_fullname.
ENDCLASS.


CLASS zcl_dummy_fullname_util IMPLEMENTATION.
  METHOD get_parts.
    DATA tokens TYPE string_table.

    SPLIT full_name AT '\' INTO TABLE tokens.

    LOOP AT tokens INTO DATA(token) WHERE table_line IS NOT INITIAL.
      " TODO: variable is assigned but never used (ABAP cleaner)
      DATA(type) = token(2).
      result = VALUE #( BASE result
                        ( name = token+3
                          tag  = token(2) ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_info_obj.
    result = NEW cl_ris_abap_fullname( iv_abap_fullname = full_name ).
  ENDMETHOD.
ENDCLASS.
