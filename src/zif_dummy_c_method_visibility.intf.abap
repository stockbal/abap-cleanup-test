"! <p class="shorttext synchronized">Method visibility</p>
INTERFACE zif_dummy_c_method_visibility
  PUBLIC.

  CONSTANTS public TYPE zif_dummy_ty_global=>ty_visibility VALUE 'public'.
  CONSTANTS protected TYPE zif_dummy_ty_global=>ty_visibility VALUE 'protected'.
  CONSTANTS private TYPE zif_dummy_ty_global=>ty_visibility VALUE 'private'.
  CONSTANTS unknown TYPE zif_dummy_ty_global=>ty_visibility VALUE 'unknown'.

ENDINTERFACE.
