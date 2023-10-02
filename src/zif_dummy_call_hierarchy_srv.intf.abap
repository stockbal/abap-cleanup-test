"! <p class="shorttext synchronized">Call Hierarchy service</p>
INTERFACE zif_dummy_call_hierarchy_srv
  PUBLIC.

  "! <p class="shorttext synchronized">Determines the called units of the given comp. unit</p>
  METHODS determine_called_elements
    IMPORTING
      abap_element  TYPE REF TO zif_dummy_abap_element
      settings      TYPE zif_dummy_ty_global=>ty_hierarchy_api_settings OPTIONAL
    RETURNING
      VALUE(result) TYPE zif_dummy_abap_element=>ty_ref_tab.
ENDINTERFACE.
