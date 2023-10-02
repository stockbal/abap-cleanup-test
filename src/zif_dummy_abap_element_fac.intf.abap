"! <p class="shorttext synchronized">ABAP element factory</p>
INTERFACE zif_dummy_abap_element_fac
  PUBLIC.

  "! <p class="shorttext synchronized">Creates ABAP element</p>
  METHODS create_abap_element
    IMPORTING
      element_info  TYPE zif_dummy_ty_global=>ty_abap_element
    RETURNING
      VALUE(result) TYPE REF TO zif_dummy_abap_element
    RAISING
      zcx_dummy_exception.
ENDINTERFACE.
