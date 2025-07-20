FROM python:latest as build

WORKDIR /src

COPY <<EOF /src/main.py
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
def main():
    print("Hello, World!")
    name = input("What's your name? ")
    print(f"Nice to meet you, {name}!")

if __name__ == "__main__":
    main()
EOF

RUN pip install pyinstaller

RUN pyinstaller --onefile --windowed main.py

FROM debian
COPY --from=build /src/main /bin/main
CMD ["/bin/main"]
