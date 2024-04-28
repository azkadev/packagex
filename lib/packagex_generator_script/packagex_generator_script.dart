// ignore_for_file: non_constant_identifier_names

// import 'dart:io';
import 'package:general_lib/script_generate/script_generate.dart';
import 'package:universal_io/io.dart';

List<ScriptGenerator> packagex_generator_script_script_generators = [
  ScriptGenerator(
    is_generate: true,
    directory_base: Directory("example"),
    file_system_entity: Directory("linux"),
    state_data: {},
    file_system_entity_type: FileSystemEntityType.directory,
    value: r"""""",
    children: [
      ScriptGenerator(
        is_generate: true,
        directory_base: Directory("example"),
        file_system_entity: Directory("linux/packagex"),
        state_data: {},
        file_system_entity_type: FileSystemEntityType.directory,
        value: r"""""",
        children: [
          ScriptGenerator(
            is_generate: true,
            directory_base: Directory("example"),
            file_system_entity: Directory("linux/packagex/DEBIAN"),
            state_data: {},
            file_system_entity_type: FileSystemEntityType.directory,
            value: r"""""",
            children: [
              ScriptGenerator(
                is_generate: true,
                directory_base: Directory("example"),
                file_system_entity: File("linux/packagex/DEBIAN/postrm"),
                state_data: {},
                file_system_entity_type: FileSystemEntityType.file,
                value: r"""#!/usr/bin/env sh
rm /usr/bin/example 
exit 0
""",
                children: [],
              )
            ],
          ),
          ScriptGenerator(
            is_generate: true,
            directory_base: Directory("example"),
            file_system_entity: Directory("linux/packagex/usr"),
            state_data: {},
            file_system_entity_type: FileSystemEntityType.directory,
            value: r"""""",
            children: [
              ScriptGenerator(
                is_generate: true,
                directory_base: Directory("example"),
                file_system_entity: Directory("linux/packagex/usr/bin"),
                state_data: {},
                file_system_entity_type: FileSystemEntityType.directory,
                value: r"""""",
                children: [],
              ),
              ScriptGenerator(
                is_generate: true,
                directory_base: Directory("example"),
                file_system_entity: Directory("linux/packagex/usr/lib"),
                state_data: {},
                file_system_entity_type: FileSystemEntityType.directory,
                value: r"""""",
                children: [],
              ),
              ScriptGenerator(
                is_generate: true,
                directory_base: Directory("example"),
                file_system_entity: Directory("linux/packagex/usr/local"),
                state_data: {},
                file_system_entity_type: FileSystemEntityType.directory,
                value: r"""""",
                children: [
                  ScriptGenerator(
                    is_generate: true,
                    directory_base: Directory("example"),
                    file_system_entity:
                        Directory("linux/packagex/usr/local/bin"),
                    state_data: {},
                    file_system_entity_type: FileSystemEntityType.directory,
                    value: r"""""",
                    children: [],
                  ),
                  ScriptGenerator(
                    is_generate: true,
                    directory_base: Directory("example"),
                    file_system_entity:
                        Directory("linux/packagex/usr/local/lib"),
                    state_data: {},
                    file_system_entity_type: FileSystemEntityType.directory,
                    value: r"""""",
                    children: [],
                  )
                ],
              ),
              ScriptGenerator(
                is_generate: true,
                directory_base: Directory("example"),
                file_system_entity: Directory("linux/packagex/usr/share"),
                state_data: {},
                file_system_entity_type: FileSystemEntityType.directory,
                value: r"""""",
                children: [
                  ScriptGenerator(
                    is_generate: true,
                    directory_base: Directory("example"),
                    file_system_entity:
                        Directory("linux/packagex/usr/share/applications"),
                    state_data: {},
                    file_system_entity_type: FileSystemEntityType.directory,
                    value: r"""""",
                    children: [
                      ScriptGenerator(
                        is_generate: true,
                        directory_base: Directory("example"),
                        file_system_entity: File(
                            "linux/packagex/usr/share/applications/example.desktop"),
                        state_data: {},
                        file_system_entity_type: FileSystemEntityType.file,
                        value: r"""[Desktop Entry]
Type=Application
Version=0.0.0
Name=example
GenericName=General Application
Exec=example -- %u
Categories=Music;Media;
Keywords=Hello;World;Test;Application;
StartupNotify=true

""",
                        children: [],
                      )
                    ],
                  ),
                  ScriptGenerator(
                    is_generate: true,
                    directory_base: Directory("example"),
                    file_system_entity:
                        Directory("linux/packagex/usr/share/example"),
                    state_data: {},
                    file_system_entity_type: FileSystemEntityType.directory,
                    value: r"""""",
                    children: [],
                  )
                ],
              )
            ],
          ),
          ScriptGenerator(
            is_generate: true,
            directory_base: Directory("example"),
            file_system_entity: File("linux/packagex/.gitignore"),
            state_data: {},
            file_system_entity_type: FileSystemEntityType.file,
            value: r"""usr/bin/example
usr/share/example
usr/local/bin/example
usr/local/share/example
""",
            children: [],
          )
        ],
      )
    ],
  ),
  ScriptGenerator(
    is_generate: true,
    directory_base: Directory("example"),
    file_system_entity: Directory("macos"),
    state_data: {},
    file_system_entity_type: FileSystemEntityType.directory,
    value: r"""""",
    children: [
      ScriptGenerator(
        is_generate: true,
        directory_base: Directory("example"),
        file_system_entity: Directory("macos/packagex"),
        state_data: {},
        file_system_entity_type: FileSystemEntityType.directory,
        value: r"""""",
        children: [
          ScriptGenerator(
            is_generate: true,
            directory_base: Directory("example"),
            file_system_entity: File("macos/packagex/.gitignore"),
            state_data: {},
            file_system_entity_type: FileSystemEntityType.file,
            value: r"""usr/bin/example
usr/share/example
usr/local/bin/example
usr/local/share/example
""",
            children: [],
          )
        ],
      )
    ],
  ),
  ScriptGenerator(
    is_generate: true,
    directory_base: Directory("example"),
    file_system_entity: Directory("windows"),
    state_data: {},
    file_system_entity_type: FileSystemEntityType.directory,
    value: r"""""",
    children: [
      ScriptGenerator(
        is_generate: true,
        directory_base: Directory("example"),
        file_system_entity: Directory("windows/packagex"),
        state_data: {},
        file_system_entity_type: FileSystemEntityType.directory,
        value: r"""""",
        children: [
          ScriptGenerator(
            is_generate: true,
            directory_base: Directory("example"),
            file_system_entity: File("windows/packagex/.gitignore"),
            state_data: {},
            file_system_entity_type: FileSystemEntityType.file,
            value: r"""usr/bin/example
usr/share/example
usr/local/bin/example
usr/local/share/example
""",
            children: [],
          )
        ],
      )
    ],
  ),
];
