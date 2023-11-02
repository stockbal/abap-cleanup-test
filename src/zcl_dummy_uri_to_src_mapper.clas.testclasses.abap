*"* use this source file for your ABAP unit test classes
CLASS ltcl_abap_unit DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    DATA uri TYPE string.
    DATA exp_uri_info TYPE zif_dummy_ty_global=>ty_adt_uri_info.

    METHODS assert_equals RAISING
                            cx_static_check.

    METHODS class_method    FOR TESTING RAISING cx_static_check.
    METHODS program_uri     FOR TESTING RAISING cx_static_check.
    METHODS function_module FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_abap_unit IMPLEMENTATION.
  METHOD assert_equals.
    DATA(mapper) = zcl_dummy_uri_to_src_mapper=>create( ).

    DATA(uri_info) = mapper->map_adt_uri_to_src( uri ).

    cl_abap_unit_assert=>assert_equals( exp = exp_uri_info
                                        act = uri_info ).
  ENDMETHOD.

  METHOD program_uri.
  ENDMETHOD.

  METHOD function_module.
    uri = `/sap/bc/adt/functions/groups/seua/fmodules/repository_environment_all/source/main#start=1,19`.

    exp_uri_info = VALUE #( uri             = uri
                            main_prog       = 'SAPLSEUA'
                            include         = 'LSEUAU46'
                            trobjtype       = 'FUGR'
                            source_position = VALUE #( line   = 1
                                                       column = 19 ) ).

    assert_equals( ).
  ENDMETHOD.

  METHOD class_method.
    uri = `/sap/bc/adt/oo/classes/zcl_dummy_test1/source/main#start=69,22`.

    DATA(classname) = CONV classname( 'ZCL_DUMMY_TEST1' ).

    exp_uri_info = VALUE #(
        uri             = uri
        main_prog       = cl_oo_classname_service=>get_classpool_name( classname )
        include         = cl_oo_classname_service=>get_method_include( VALUE #( clsname = classname
                                                                                cpdname = 'TEST4' ) )
        trobjtype       = 'CLAS'
        source_position = VALUE #( line   = 2
                                   column = 22 ) ).

    assert_equals( ).
  ENDMETHOD.
ENDCLASS.
