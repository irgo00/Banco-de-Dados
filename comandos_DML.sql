--------------------------------TIPOS DE ATRIBUTOS --------------------------------------------

Numéricos:

INT: Números inteiros com ou sem sinal
TINYINT: Números inteiros pequenos com ou sem sinal
SMALLINT: Números inteiros menores com ou sem sinal
MEDIUMINT: Números inteiros médios com ou sem sinal
BIGINT: Números inteiros grandes com ou sem sinal
FLOAT: Números de ponto flutuante de precisão simples
DOUBLE: Números de ponto flutuante de precisão dupla
DECIMAL: Números de ponto fixo exatos (com casas decimais definidas)

Strings (caracteres):

CHAR: Strings de tamanho fixo (1 a 255 caracteres)
VARCHAR: Strings de tamanho variável (até 65.535 caracteres)
TEXT: Strings longas (até 65.535 caracteres)
MEDIUMTEXT: Strings mais longas (até 16.777.215 caracteres).
LONGTEXT: Strings ainda mais longas (até 4.294.967.295 caracteres).

Data e hora:

DATE: Datas no formato AAAA-MM-DD ('2021-06-30', '1999-12-31').
TIME: Horas, minutos e segundos no formato HH:MM:SS ('14:30:00', '23:59:59').
DATETIME: Datas e horas no formato AAAA-MM-DD HH:MM:SS ('2021-06-30 14:30:00', '1999-12-31 23:59:59').
TIMESTAMP: Semelhante ao DATETIME, mas com intervalo de '1970-01-01 00:00:01' UTC a '2038-01-19 03:14:07' UTC ('2021-06-30 14:30:00', '1999-12-31 23:59:59').
YEAR: Apenas o ano no formato AAAA ou AA (1901 a 2155 ou 1970 a 2069) ('2021', '1999').

IDs:

UNSIGNED: Não permite a inserção de números negativos
AUTO_INCREMENT: a cada inserção, o ID será incrementado automaticamente, sem a necessidade de inserir ele junto com as outras informações
ZEROFILL: preenche espaços em uma coluna, substituindo por 0. Ex: se uma coluna é declarada como INT(4), o ID 5 será 0005
NOT NULL: não permite deixar o campo vazio