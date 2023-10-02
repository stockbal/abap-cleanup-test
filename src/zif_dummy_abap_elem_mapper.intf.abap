"! <p class="shorttext synchronized">Mapper for ABAP Elements</p>
INTERFACE zif_dummy_abap_elem_mapper
  PUBLIC.

  "! <p class="shorttext synchronized">Maps given URI to sructure of ABAP element</p>
  "! A valid ABAP element is either a method a function module or a form. <br/>
  "! No other ABAP elements are supported at this time
  METHODS map_uri_to_abap_element
    IMPORTING
      uri           TYPE string
    RETURNING
      VALUE(result) TYPE zif_dummy_ty_global=>ty_abap_element
    RAISING
      zcx_dummy_exception.

  "! <p class="shorttext synchronized">Maps given compiler full name to sructure of ABAP element</p>
  "! A valid ABAP element is either a method a function module or a form. <br/>
  "! No other ABAP elements are supported at this time
  METHODS map_full_name_to_abap_element
    IMPORTING
      full_name     TYPE string
      main_prog     TYPE progname
    RETURNING
      VALUE(result) TYPE zif_dummy_ty_global=>ty_abap_element
    RAISING
      zcx_dummy_exception.

ENDINTERFACE.
