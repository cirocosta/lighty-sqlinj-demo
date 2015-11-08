# Apresentação

- [ ] Explicar a falha
  - [ ] apresentar o serviço a ser explorado
  - [ ] onde, no código fonte, está a falha
  - [ ] path de correção da falha
- [ ] Preparar demos com relação ao exploit
  - [ ] Exploit
  - [ ] Aplicar a correção da falha 
  - [ ] Tentar explorar novamente

## lighttpd

## Virtual Hosting

> Method for hosting multiple domain names on a single (or pool of) server(s). Widely used for shared web hosting where hosting prices get lower than a dedicated web server as memory and processor cycles are shared.

Pode ser ip-based (uma interface para cada host) ou name-based (um nome para cada host, compartilhando a interface).

### Name-Based

> A technical prerequisite needed for name-based virtual hosts is a web browser with HTTP/1.1 support (commonplace today) to include the target hostname in the request. This allows a server hosting multiple sites behind an IP address to deliver the correct site's content.

Problemas: **TODO**

### Preparando um servidor

Preparar um servidor básico `lighttpd`  é muito fácil. Basta realizar sua instalação e criar um arquivo de configuração que dita a porta que será utilizada, como responder a determinadas requisições e outras configurações.

Podemos prepara um exemplo de configuração que trata apenas de receber requests de arquivos estáticos (`.html` ou `.txt`):

```
server.document-root = "/usr/lighttpd/mysite.com/"
server.port = 80

mimetype.assign = (
  ".html" => "text/html",
  ".txt" => "text/plain"
)
```

Imagine agora que desejamos criar um negócio baseado em venda de sites e oferecemos domínio próprio ao comprador. Visão minimizar os custos desejamos então usar criar *vhosts* para cada cliente. Digamos que o curso da disciplina de redes deseja adquiri três websites: `redes.io`, `mac0448.io` e `mac5910.io`. Nossa empresa então registra os domínios, todos apontando para o IP de nosso único servidor, de única interface.

ps: como desejamos simular isso podemos alterar o arquivo `/etc/hosts`:
```
172.17.0.2 redes.io
172.17.0.2 mac0448.io
172.17.0.2 mac5910.io
```

Para que sejamos capazes de servir os diferentes websites dos clientes resolvendo a partir de um único IP podemos então, na mão, configurar o servidor:

```
server.document-root = "/usr/lighttpd/default/"
server.port = 80

mimetype.assign = (
  ".html" => "text/html",
  ".txt" => "text/plain"
)

$HTTP["host"] == "redes.io" {
  server.document-root = "/usr/lighttpd/redes/"
} else $HTTP["host"] == "mac0448.io" {
  server.document-root = "/usr/lighttpd/mac0448/"
} else $HTTP["host"] == "mac5910.io" {
  server.document-root = "/usr/lighttpd/mac5910/"
}
``` 

Mas, como podemos imaginar, isto pode tornar-se um problema à medida que desejamos lidar com muitos clientes e prover diferentes configurações a cada website.

TODO


### Ip-Based



## sql

SQL se trata de uma linguagem para 'conversar' com databases através de uma linguagem bastante alta - chega a lembrar bastante inglês.

- SELECT
- INSERT
- UPDATE
- DELETE
- DROP
- (...)

TODO

### sql injection

O problema com as SQL queries aparecem quando passou a haver a intenção de construir tais queries usando strings que usuários entram.

Como resolver? Escaping.

TODO

## Docker Networking

TODO


## Ataque

Utilizando o `curl` podemos realizar o ataque através do uso de requests mal intencionados como descrito na confirmação da CVE.

```sh
$ curl --header "Host: []' UNION SELECT'" redes.io
```

TODO


