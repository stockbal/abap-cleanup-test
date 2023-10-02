"! <p class="shorttext synchronized" lang="en">Method visibility</p>
INTERFACE zif_dummy_c_method_visibility
  PUBLIC.

  CONSTANTS:
    public    TYPE zif_dummy_ty_global=>ty_visibility VALUE 'public',
    protected TYPE zif_dummy_ty_global=>ty_visibility VALUE 'protected',
    private   TYPE zif_dummy_ty_global=>ty_visibility VALUE 'private',
    unknown   TYPE zif_dummy_ty_global=>ty_visibility VALUE 'unknown'.

ENDINTERFACE.
