"! <p class="shorttext synchronized">General Exception</p>
CLASS zcx_dummy_exception DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    DATA msgv1 TYPE sy-msgv1.
    DATA msgv2 TYPE sy-msgv2.
    DATA msgv3 TYPE sy-msgv3.
    DATA msgv4 TYPE sy-msgv4.

    "! <p class="shorttext synchronized">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
        !previous LIKE previous OPTIONAL
        !text     TYPE string   OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcx_dummy_exception IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    DATA fill_t100key TYPE abap_bool.

    super->constructor( previous = previous ).

    CLEAR textid.

    IF text IS NOT INITIAL.
      fill_t100key = abap_true.
      zcl_dummy_message_util=>split_string_to_symsg( text ).
    ELSEIF sy-msgid IS NOT INITIAL.
      fill_t100key = abap_true.
    ENDIF.

    IF fill_t100key = abap_true.
      msgv1 = sy-msgv1.
      msgv2 = sy-msgv2.
      msgv3 = sy-msgv3.
      msgv4 = sy-msgv4.
      if_t100_message~t100key = VALUE #( msgid = sy-msgid
                                         msgno = sy-msgno
                                         attr1 = 'MSGV1'
                                         attr2 = 'MSGV2'
                                         attr3 = 'MSGV3'
                                         attr4 = 'MSGV4' ).
    ELSE.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ENDIF.

    me->previous = previous.
  ENDMETHOD.
ENDCLASS.
