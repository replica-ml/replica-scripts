replica-scripts
===============

Mostly deployment scripts.

  - Linux variants are useful in Docker, other image types [e.g., see Packer, Unikernels], and natively;
  - macOS variant is useful for native usage;
  - Windows—coming soon—is useful for Windows Containers, other image types, and natively.

## Usage

   ./setup.sh

See [`conf.env.sh`](./conf.env.sh) for options that can be overriden by setting environment variables.

### Docker usage

For debugging, you might want to run something like:

   docker build --file debian.Dockerfile --progress='plain' --no-cache --tag "${PWD##*/}":debian .

<hr/>

## License

Licensed under either of:

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or <https://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or <https://opensource.org/licenses/MIT>)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
licensed as above, without any additional terms or conditions.
