MACRO(ADD_TO_TORCH_DOC_INDEX dstdir section title rank)
    INSTALL(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/"
        DESTINATION "${Torch_INSTALL_PREFIX}/${Torch_INSTALL_HTML_SUBDIR}/${dstdir}")
    ADD_CUSTOM_TARGET(${dstdir}-dok-index
        ALL
        ${Torch_SOURCE_LUA}
        "${Torch_SOURCE_CMAKE}/dok/dokindex.lua"
        "${Torch_SOURCE_PKG_PATH}/dok/init.lua"
        "${TORCH_DOK_HTML_TEMPLATE}"
        "${CMAKE_BINARY_DIR}/dokindex.lua"
        "${Torch_INSTALL_SHARE}/torch/dokindex.lua"
        "${CMAKE_BINARY_DIR}/dok/index.txt"
        "${CMAKE_BINARY_DIR}/html/index.html"
        "${dstdir}" "${section}" "${title}" "${rank}"
        DEPENDS
        "${Torch_SOURCE_CMAKE}/dok/dokindex.lua"
        "${Torch_SOURCE_PKG_PATH}/dok/init.lua"
        COMMENT "Generating main documentation index"
        )
    INSTALL(DIRECTORY "${CMAKE_BINARY_DIR}/html/"
        DESTINATION "${Torch_INSTALL_PREFIX}/${Torch_INSTALL_HTML_SUBDIR}")
ENDMACRO(ADD_TO_TORCH_DOC_INDEX)

ADD_TO_TORCH_DOC_INDEX(cephes "Mathematics" "Cephes Mathematical Functions" 6.1)
