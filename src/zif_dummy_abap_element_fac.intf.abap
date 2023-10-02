"! <p class="shorttext synchronized" lang="en">ABAP element factory</p>
INTERFACE zif_dummy_abap_element_fac
  PUBLIC.

  METHODS:
    "! <p class="shorttext synchronized" lang="en">Creates ABAP element</p>
    create_abap_element
      IMPORTING
        element_info     TYPE zif_dummy_ty_global=>ty_abap_element
      RETURNING
        VALUE(result) TYPE REF TO zif_dummy_abap_element
      RAISING
        zcx_dummy_exception.
ENDINTERFACE.
