"! <p class="shorttext synchronized">Reads descriptions for elements</p>
CLASS zcl_dummy_elem_descr_reader DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_dummy_elem_descr_reader.

    CLASS-METHODS get_instance
      RETURNING
        VALUE(result) TYPE REF TO zif_dummy_elem_descr_reader.

  PRIVATE SECTION.
    CLASS-DATA instance TYPE REF TO zif_dummy_elem_descr_reader.

    METHODS get_method_description
      IMPORTING
        elem_info     TYPE zif_dummy_ty_global=>ty_abap_element
      RETURNING
        VALUE(result) TYPE string.

    METHODS get_function_description
      IMPORTING
        elem_info     TYPE zif_dummy_ty_global=>ty_abap_element
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.


CLASS zcl_dummy_elem_descr_reader IMPLEMENTATION.
  METHOD get_instance.
    IF instance IS INITIAL.
      instance = NEW zcl_dummy_elem_descr_reader( ).
    ENDIF.

    result = instance.
  ENDMETHOD.

  METHOD zif_dummy_elem_descr_reader~get_description.
    CASE elem_info-tag.

      WHEN cl_abap_compiler=>tag_method.
        result = get_method_description( elem_info ).

      WHEN cl_abap_compiler=>tag_function.
        result = get_function_description( elem_info ).
    ENDCASE.
  ENDMETHOD.

  METHOD get_method_description.
    DATA class_name TYPE classname.
    DATA method_parts TYPE string_table.
    DATA method_name TYPE seocmpname.

    IF elem_info-legacy_type <> swbm_c_type_cls_mtd_impl.
      RETURN.
    ENDIF.

    IF elem_info-method_props-name CS '~'.
      SPLIT elem_info-method_props-name AT '~' INTO TABLE method_parts.
      class_name = method_parts[ 1 ].
      method_name = method_parts[ 2 ].
    ELSE.
      class_name = elem_info-encl_object_name.
      method_name = elem_info-method_props-name.
    ENDIF.
    SELECT SINGLE descript
      FROM seocompotx
      WHERE clsname = @class_name
        AND cmpname = @method_name
        AND langu = @sy-langu
      INTO @result.
  ENDMETHOD.

  METHOD get_function_description.
    DATA(func_name) = CONV funcname( elem_info-object_name ).

    SELECT SINGLE stext
      FROM tftit
      WHERE funcname = @func_name
        AND spras = @sy-langu
      INTO @result.
  ENDMETHOD.
ENDCLASS.
