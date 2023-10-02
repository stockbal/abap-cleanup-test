"! <p class="shorttext synchronized">Object does not exist error</p>
CLASS zcx_dummy_not_exists DEFINITION
  PUBLIC
  INHERITING FROM zcx_dummy_exception
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! <p class="shorttext synchronized">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
        !previous LIKE previous OPTIONAL
        !text     TYPE string   OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcx_dummy_not_exists IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous text = text ).
  ENDMETHOD.
ENDCLASS.
