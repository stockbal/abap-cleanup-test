"! <p class="shorttext synchronized">Util for function modules</p>
CLASS zcl_dummy_func_util DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    "! <p class="shorttext synchronized">Retrieves program for function group name</p>
    CLASS-METHODS get_progname_for_group
      IMPORTING
        !group        TYPE rs38l_area
      RETURNING
        VALUE(result) TYPE progname
      RAISING
        zcx_dummy_not_exists.

    "! <p class="shorttext synchronized">Returns 'X' if function module exists</p>
    CLASS-METHODS function_exists
      IMPORTING
        function_module TYPE tfdir-funcname
      RETURNING
        VALUE(result)   TYPE abap_bool.

    "! <p class="shorttext synchronized">Retrieves include for function module name</p>
    CLASS-METHODS get_function_include_by_fname
      IMPORTING
        function_module TYPE tfdir-funcname
      RETURNING
        VALUE(result)   TYPE progname.

    "! <p class="shorttext synchronized">Retrieves function module information</p>
    CLASS-METHODS get_function_module_info
      IMPORTING
        function_module TYPE tfdir-funcname
      RETURNING
        VALUE(result)   TYPE zif_dummy_ty_global=>ty_function_info
      RAISING
        zcx_dummy_not_exists.

    "! <p class="shorttext synchronized">Retrieves function module info by include name</p>
    CLASS-METHODS get_func_module_by_include
      IMPORTING
        !include      TYPE progname
      RETURNING
        VALUE(result) TYPE zif_dummy_ty_global=>ty_function_info
      RAISING
        zcx_dummy_not_exists.
ENDCLASS.


CLASS zcl_dummy_func_util IMPLEMENTATION.
  METHOD function_exists.
    TRY.
        get_function_module_info( function_module ).
        result = abap_true.
      CATCH zcx_dummy_not_exists.
    ENDTRY.
  ENDMETHOD.

  METHOD get_function_module_info.
    result-name = function_module.
    result-name = to_upper( result-name ).

    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING  funcname           = result-name
      IMPORTING  group              = result-group
                 include            = result-include
      EXCEPTIONS function_not_exist = 1
                 OTHERS             = 2.
    IF sy-subrc <> 0.
      CLEAR result.
      RAISE EXCEPTION TYPE zcx_dummy_not_exists
        EXPORTING text = |Function module { function_module } does not exist|.
    ENDIF.
  ENDMETHOD.

  METHOD get_func_module_by_include.
    result-include = include.
    result-include = to_upper( result-include ).

    CALL FUNCTION 'FUNCTION_INCLUDE_INFO'
      CHANGING   funcname            = result-name
                 group               = result-group
                 include             = result-include
      EXCEPTIONS function_not_exists = 1
                 include_not_exists  = 2
                 group_not_exists    = 3
                 no_selections       = 4
                 no_function_include = 5
                 OTHERS              = 6.
    IF sy-subrc <> 0.
      CLEAR result.
      RAISE EXCEPTION TYPE zcx_dummy_not_exists
        EXPORTING text = |Function include { include } does not exist|.
    ENDIF.
  ENDMETHOD.

  METHOD get_function_include_by_fname.
    DATA(funcname) = CONV rs38l_fnam( to_upper( function_module ) ).

    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING  funcname           = function_module
      IMPORTING  include            = result
      EXCEPTIONS function_not_exist = 1
                 OTHERS             = 2.
  ENDMETHOD.

  METHOD get_progname_for_group.
    DATA(l_group) = CONV rs38l_area( to_upper( group ) ).

    CALL FUNCTION 'FUNCTION_INCLUDE_INFO'
      IMPORTING  pname  = result
      CHANGING   group  = l_group
      EXCEPTIONS OTHERS = 1.
    IF sy-subrc <> 0.
      CLEAR result.
      RAISE EXCEPTION TYPE zcx_dummy_not_exists
        EXPORTING text = |Function group { group } does not exist|.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
