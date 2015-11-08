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

O serviço a ser explorado trata-se do Lighttpd. Esté é um Webserver opensource (licensa BSD) otimizado para ser leve e rápido. Surgiu como uma 'proof-of-concept' do famoso problema c10k (como lidar com 10mil conexões simultaneas em um servidor), tendo então ganhado bastante popularidade à época (2003), sendo atualmente utilizado pela Wikimedia, Xkcd e no passado sendo utilizado pelo Youtube. Seu posicionamento no mercado é bastante interessante, como podemos verificar no gráfico:

![Posicionamento Lighttpd - Tráfego x Quantidade de Websites](assets/lighttpd-market-pos.png)

Ele busca lidar com o problema de muitas conexões através do uso de mecanismos assíncronos através de eventos (`kqueue` em BSDs, `epoll` em Linux) reduzindo a necessidade de várias threads, resultando então em um memory footprint muito menor e melhor utilização de CPU (estratégia também utilizada por servidores Nginx, cujo uso tem aumentado significativamente ao longo dos anos):

![Mercado Servidores](servers-market.png)


## Virtual Hosting

> Method for hosting multiple domain names on a single (or pool of) server(s). Widely used for shared web hosting where hosting prices get lower than a dedicated web server as memory and processor cycles are shared.

Pode ser ip-based (uma interface para cada host) ou name-based (um nome para cada host, compartilhando a interface).

### Name-Based

> A technical prerequisite needed for name-based virtual hosts is a web browser with HTTP/1.1 support (commonplace today) to include the target hostname in the request. This allows a server hosting multiple sites behind an IP address to deliver the correct site's content.

Problemas: **TODO**

### Ip-Based


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

## Docker

Provém uma camada de abstração em cima do sistema operacional permitindo virtualização sem a necessidade de outro sistema operacional através do uso de mecanismos de isolamento fornecidos pelo kernel, como `cgroups` e `namespaces`, removendo então todo o overhead de inciar e manter uma máquina virtual. Há, dessa forma, grande otimização referente à alocação de recursos (e.g, 100 máquinas virtuais com imagens de 1GB ==> 100GB. 100 containers de uma imagem de 1GB ==> ~1GB.) e compartilhamento de processamento, assim como o Kernel e o sistema operacional em si. Arquivos comuns aos containers podem também ser compartilhados por meio de um sistem de arquivos em camadas (TODO).

Deve-se levar em conta que eventualmente o usuário não deseje tal compartilhamento e pouco isolamente.

### Namespaces


### Docker Networking

```
   The Internet Assigned Numbers Authority (IANA) has reserved the
   following three blocks of the IP address space for private internets:

     10.0.0.0        -   10.255.255.255  (10/8 prefix)
     172.16.0.0      -   172.31.255.255  (172.16/12 prefix)
     192.168.0.0     -   192.168.255.255 (192.168/16 prefix)
```

Quando docker iniicia, cria uma interface virtual chamada `docker0` no host.


## Demo!

A demonstração depende de um ambiente com  [docker](docker.io) propriamente instalado. Feito isto, as imagens precisam ser criadas:

```sh
$ ./run-build-images.sh
```

O comando acima executará, para cada imagem - debian com lighttpd vulnerável e outra com lighttpd não vulnerável - o processo de criação explícito nos `Dockerfile`s correspondentes.

Feito isto, podemos então instanciar os containers que representarão as instâncias de processamento que fazem parte da demo:

- um servidor de mysql escutando na porta 3306 do `lighty-mysqlserver`.
- um servidor lighty escutando na porta 80 do  `lighty-vulnerable`.
- um servidor lighty escutando na porta 80 do container `lighty-patched`.

Para obter os IPs dos containers, basta executar o comando:

```sh
$ ./run-getips.sh

Docker container ip Addresses:
 - lighty-vulnerable:  172.17.0.3
 - lighty-patched:  172.17.0.4
 - lighty-mysqlserver: 172.17.0.2
```

As supostas máquinas estão prontas, resta apenas configurar o DNS para que a resolução de endereços seja feita corretamente.

(agora poderíamos criar outro container, dedicado à resolução usando BIND, porém para agilizar podemos simplesmente editar o `/etc/hosts`):

```
172.17.0.3 redes.io
172.17.0.3 mac0448.io
172.17.0.3 mac5910.io
```

Precisamos agora fazer com que o servidor `lighttpd` seja capaz de fazer a tarefa de virtual hosting usando o servidor de mysql. Para isto precisamos inserir as entradas no servidor:

```sh
$ docker exec -it lighty-mysqlserver bash
root@lighty-mysqlserver:/# mysql -u root -p
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| lighttpd           |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
mysql> use lighttpd;
mysql> mysql> CREATE TABLE domains(
    -> domain varchar(64) not null primary key,
    -> docroot varchar(128) not null
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO domains VALUES ('redes.io', '/usr/lighttpd/redes/');
mysql> INSERT INTO domains VALUES ('mac5910.io', '/usr/lighttpd/mac5910/');
mysql> INSERT INTO domains VALUES ('mac0448.io', '/usr/lighttpd/mac0448/');

mysql> SELECT * FROM domains;
+------------+------------------------+
| domain     | docroot                |
+------------+------------------------+
| mac0448.io | /usr/lighttpd/mac0448/ |
| mac5910.io | /usr/lighttpd/mac5910/ |
| redes.io   | /usr/lighttpd/redes/   |
+------------+------------------------+

```

### Exploit

Utilizando o `curl` podemos realizar o ataque através do uso de requests mal intencionados como descrito na confirmação da CVE.

```sh
$ curl --header "Host: []' UNION SELECT'" redes.io
```

TODO

### Obtendo os IPs

```sh
$ docker ps | grep 'lighty' | awk '{print $1}'
```

### Verificação do Path

Podemos verificar que o patch resolve o problema primeiramente refazendo os testes incluídos:

```
```sh
$ curl --header "Host: []' UNION SELECT'" redes.io
```

