*"* use this source file for your ABAP unit test classes
CLASS ltcl_unit DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    DATA uri_input TYPE string.
    DATA full_name_input TYPE string.
    DATA main_prog_input TYPE progname.

    DATA fragment TYPE cl_adt_text_plain_fragmnt_hndl=>ty_fragment_parsed.
    DATA exp_fullname TYPE string.
    DATA exp_object_name TYPE string.
    DATA exp_encl_obj_name TYPE string.
    DATA exp_tag TYPE scr_tag.
    DATA act_abap_element TYPE zif_dummy_ty_global=>ty_abap_element.
    DATA error TYPE REF TO cx_static_check.
    DATA is_error_ok TYPE abap_bool.

    METHODS assert_equals RAISING
                            cx_static_check.

    METHODS test_map_uri_to_ae RAISING
                                 cx_static_check.

    METHODS test_map_fullname_to_ae RAISING
                                      cx_static_check.

    METHODS uri_without_fragment           FOR TESTING RAISING cx_static_check.
    METHODS normal_method_uri              FOR TESTING RAISING cx_static_check.
    METHODS interface_method_impl_uri      FOR TESTING RAISING cx_static_check.
    METHODS function_call_uri              FOR TESTING RAISING cx_static_check.
    METHODS form_call_inside_function_uri  FOR TESTING RAISING cx_static_check.

    "! Call of interface method with pattern [class->interface~method]
    METHODS class_intf_method_call_uri     FOR TESTING RAISING cx_static_check.
    METHODS interface_method_call          FOR TESTING RAISING cx_static_check.
    METHODS form_call_uri                  FOR TESTING RAISING cx_static_check.
    METHODS local_cls_alias_meth_call_uri  FOR TESTING RAISING cx_static_check.
    METHODS redef_intf_meth_definition_uri FOR TESTING RAISING cx_static_check.

    METHODS normal_method_fullname         FOR TESTING RAISING cx_static_check.
    METHODS intf_method_impl_fullname      FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_unit IMPLEMENTATION.
  METHOD test_map_uri_to_ae.
    DATA(pos_mapper) = zcl_dummy_abap_elem_mapper=>create( ).
    TRY.
        act_abap_element = pos_mapper->map_uri_to_abap_element( uri = uri_input ).
      CATCH zcx_dummy_exception INTO error.
    ENDTRY.
  ENDMETHOD.

  METHOD test_map_fullname_to_ae.
    DATA(pos_mapper) = zcl_dummy_abap_elem_mapper=>create( ).
    TRY.
        act_abap_element = pos_mapper->map_full_name_to_abap_element( full_name = full_name_input
                                                                      main_prog = main_prog_input ).
      CATCH zcx_dummy_exception INTO error.
    ENDTRY.
  ENDMETHOD.

  METHOD assert_equals.
    IF is_error_ok = abap_true.
      cl_abap_unit_assert=>assert_bound( error ).
      RETURN.
    ELSE.
      cl_abap_unit_assert=>assert_not_bound( error ).
    ENDIF.

    cl_abap_unit_assert=>assert_equals( act = act_abap_element-full_name
                                        exp = exp_fullname ).
    cl_abap_unit_assert=>assert_equals( act = act_abap_element-tag
                                        exp = exp_tag ).
    cl_abap_unit_assert=>assert_equals( act = act_abap_element-object_name
                                        exp = exp_object_name ).
    cl_abap_unit_assert=>assert_equals( act = act_abap_element-encl_object_name
                                        exp = exp_encl_obj_name ).
  ENDMETHOD.

  METHOD uri_without_fragment.
    uri_input = `/sap/bc/adt/oo/classes/zcl_dummy_test1/source/main`.
    is_error_ok = abap_true.
    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD normal_method_uri.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = 'ZCL_DUMMY_TEST1' ).

    fragment-start = VALUE #( line = 24 offset = 11 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = 'ZCL_DUMMY_TEST1'
                                                                           fragment   = fragment ).

    exp_fullname = '\TY:ZCL_DUMMY_TEST1\ME:TEST1'.
    exp_object_name = 'TEST1'.
    exp_encl_obj_name = 'ZCL_DUMMY_TEST1'.
    exp_tag = 'ME'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD normal_method_fullname.
    exp_fullname = '\TY:ZCL_DUMMY_TEST1\ME:TEST1'.
    full_name_input = '\TY:ZCL_DUMMY_TEST1\ME:TEST1'
      .
    main_prog_input = cl_oo_classname_service=>get_classpool_name( 'ZCL_DUMMY_TEST1' ).

    exp_object_name = 'TEST1'.
    exp_encl_obj_name = 'ZCL_DUMMY_TEST1'.
    exp_tag = 'ME'.

    test_map_fullname_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD interface_method_impl_uri.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = 'ZCL_DUMMY_TEST1' ).

    fragment-start = VALUE #( line = 32 offset = 28 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = 'ZCL_DUMMY_TEST1'
                                                                           fragment   = fragment ).

    exp_fullname = '\TY:ZCL_DUMMY_TEST1\IN:ZIF_DUMMY_TEST1\ME:RUN'.
    exp_object_name = 'ZIF_DUMMY_TEST1~RUN'.
    exp_encl_obj_name = 'ZCL_DUMMY_TEST1'.
    exp_tag = 'ME'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD intf_method_impl_fullname.
    exp_fullname = '\TY:ZCL_DUMMY_TEST1\IN:ZIF_DUMMY_TEST1\ME:RUN'.
    full_name_input = '\TY:ZCL_DUMMY_TEST1\IN:ZIF_DUMMY_TEST1\ME:RUN'
      .

    main_prog_input = cl_oo_classname_service=>get_classpool_name( 'ZCL_DUMMY_TEST1' ).

    exp_object_name = 'ZIF_DUMMY_TEST1~RUN'.
    exp_encl_obj_name = 'ZCL_DUMMY_TEST1'.
    exp_tag = 'ME'.

    test_map_fullname_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD function_call_uri.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = 'ZCL_DUMMY_TEST1' ).

    fragment-start = VALUE #( line = 58 offset = 31 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = 'ZCL_DUMMY_TEST1'
                                                                           fragment   = fragment ).

    exp_fullname = '\FU:REPOSITORY_ENVIRONMENT_ALL'.
    exp_object_name = 'REPOSITORY_ENVIRONMENT_ALL'.
    exp_encl_obj_name = ''.
    exp_tag = 'FU'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD form_call_inside_function_uri.
    uri_input = `/sap/bc/adt/functions/groups/seua/fmodules/repository_environment_all/source/main#start=27,21`.

    exp_fullname = '\PR:SAPLSEUA\FO:SAVE_FOR_RECURRENCE'.
    exp_object_name = 'SAVE_FOR_RECURRENCE'.
    exp_encl_obj_name = 'SAPLSEUA'.
    exp_tag = 'FO'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD interface_method_call.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = 'ZCL_DUMMY_TEST1' ).

    fragment-start = VALUE #( line = 62 offset = 34 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = 'ZCL_DUMMY_TEST1'
                                                                           fragment   = fragment ).

    exp_fullname = '\TY:ZIF_DUMMY_TEST2\ME:EXECUTE'.
    exp_object_name = 'EXECUTE'.
    exp_encl_obj_name = 'ZIF_DUMMY_TEST2'.
    exp_tag = 'ME'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD class_intf_method_call_uri.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = 'ZCL_DUMMY_TEST1' ).

    fragment-start = VALUE #( line = 64 offset = 41 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = 'ZCL_DUMMY_TEST1'
                                                                           fragment   = fragment ).

    exp_fullname = '\TY:ZCL_DUMMY_TEST2\IN:ZIF_DUMMY_TEST2\ME:EXECUTE'.
    exp_object_name = 'ZIF_DUMMY_TEST2~EXECUTE'.
    exp_encl_obj_name = 'ZCL_DUMMY_TEST2'.
    exp_tag = 'ME'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD form_call_uri.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = 'ZCL_DUMMY_TEST1' ).

    fragment-start = VALUE #( line = 69 offset = 25 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = 'ZCL_DUMMY_TEST1'
                                                                           fragment   = fragment ).

    exp_fullname = '\PR:SAPLSEUA\FO:SAVE_FOR_RECURRENCE'.
    exp_object_name = 'SAVE_FOR_RECURRENCE'.
    exp_encl_obj_name = 'SAPLSEUA'.
    exp_tag = 'FO'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD local_cls_alias_meth_call_uri.
    DATA(classname) = CONV classname( 'ZCL_DUMMY_TEST1' ).
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = classname ).

    fragment-start = VALUE #( line = 27 offset = 25 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = classname
                                                                           fragment   = fragment ).

    exp_fullname = |\\PR:{ cl_oo_classname_service=>get_classpool_name( classname ) }| &&
                        |\\TY:LCL_LOCAL\\IN:ZIF_DUMMY_TEST1\\ME:RUN|.
    exp_object_name = 'LCL_LOCAL->ALIAS_FOR_RUN'.
    exp_encl_obj_name = cl_oo_classname_service=>get_classpool_name( classname ).
    exp_tag = 'ME'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.

  METHOD redef_intf_meth_definition_uri.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(clif_source) = cl_oo_factory=>create_instance( )->create_clif_source( clif_name = 'ZCL_DUMMY_TEST3' ).

    fragment-start = VALUE #( line = 9 offset = 32 ).
    uri_input = cl_oo_adt_uri_builder_class=>create_uri_for_class_include( class_name = 'ZCL_DUMMY_TEST3'
                                                                           fragment   = fragment ).

    exp_fullname = `\TY:ZCL_DUMMY_TEST3\IN:ZIF_DUMMY_TEST1\ME:RUN`.
    exp_object_name = 'ZIF_DUMMY_TEST1~RUN'.
    exp_encl_obj_name = 'ZCL_DUMMY_TEST3'.
    exp_tag = 'ME'.

    test_map_uri_to_ae( ).
    assert_equals( ).
  ENDMETHOD.
ENDCLASS.
