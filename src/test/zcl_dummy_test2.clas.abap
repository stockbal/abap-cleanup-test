CLASS zcl_dummy_test2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_dummy_test2.
ENDCLASS.


CLASS zcl_dummy_test2 IMPLEMENTATION.
  METHOD zif_dummy_test2~execute.
    CALL FUNCTION 'RS_PROGNAME_SPLIT'
      EXPORTING  progname_with_namespace = space
      EXCEPTIONS delimiter_error         = 0.
  ENDMETHOD.
ENDCLASS.
