"! <p class="shorttext synchronized" lang="en">Call hierarchy for method/form/function</p>
CLASS zcl_dummy_call_hierarchy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS:
      "! <p class="shorttext synchronized" lang="en">Retrieves hierarchy service instance</p>
      get_call_hierarchy_srv
        RETURNING
          VALUE(result) TYPE REF TO zif_dummy_call_hierarchy_srv,
      "! <p class="shorttext synchronized" lang="en">Retrieves ABAP element at URI</p>
      get_abap_element_from_uri
        IMPORTING
          uri           TYPE string
        RETURNING
          VALUE(result) TYPE REF TO zif_dummy_abap_element
        RAISING
          zcx_dummy_exception,
      "! <p class="shorttext synchronized" lang="en">Retrieves ABAP element via full name identifier</p>
      get_abap_elem_from_full_name
        IMPORTING
          full_name     TYPE string
        RETURNING
          VALUE(result) TYPE REF TO zif_dummy_abap_element
        RAISING
          zcx_dummy_exception.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA:
      hierarchy_srv TYPE REF TO zif_dummy_call_hierarchy_srv.
ENDCLASS.



CLASS zcl_dummy_call_hierarchy IMPLEMENTATION.

  METHOD get_abap_element_from_uri.
    DATA(element_info) = zcl_dummy_abap_elem_mapper=>create( )->map_uri_to_abap_element( uri ).
    result = zcl_dummy_abap_element_fac=>get_instance( )->create_abap_element( element_info = element_info ).
  ENDMETHOD.


  METHOD get_abap_elem_from_full_name.
    DATA(element_info) = zcl_dummy_abap_elem_mapper=>create( )->map_full_name_to_abap_element(
      full_name = full_name
      main_prog = zcl_dummy_mainprog_resolver=>get_from_full_name( full_name ) ).

    result = zcl_dummy_abap_element_fac=>get_instance( )->create_abap_element( element_info = element_info ).
  ENDMETHOD.


  METHOD get_call_hierarchy_srv.
    IF hierarchy_srv IS INITIAL.
      hierarchy_srv = NEW zcl_dummy_call_hierarchy_srv(
        abap_elem_factory = zcl_dummy_abap_element_fac=>get_instance( ) ).
    ENDIF.

    result = hierarchy_srv.
  ENDMETHOD.

ENDCLASS.
