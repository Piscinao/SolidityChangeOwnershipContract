// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Armazena e recupera um valor em uma variável
 */
contract Storage {

    uint256 number; // Armazena um número inteiro (uint256)
    address owner; // Armazena o endereço do proprietário do contrato

    // Modificador que restringe o acesso a funções apenas ao proprietário
    modifier onlyOwner () {
        require(msg.sender == owner, "only owner"); // Verifica se o remetente é o proprietário
        _; // Continua a execução da função
    }

    // Construtor que define o proprietário como o endereço que executou a transação de implantação
    constructor() {
        owner = msg.sender; // 'msg.sender' é o remetente da chamada atual, que é o criador do contrato
    }

    /**
     * @dev Armazena um valor na variável
     * @param num valor a ser armazenado
     */
    function store(uint256 num) public onlyOwner {
        number = num; // Armazena o valor na variável 'number'
    }

    // Permite que o proprietário mude o endereço do proprietário do contrato
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner; // Atualiza o proprietário
    }

    // Função que permite que o contrato receba Ether
    function pay() public payable {}

    /**
     * @dev Retorna o valor armazenado
     * @return valor de 'number'
     */
    function retrieve() public view returns (uint256) {
        return number; // Retorna o valor armazenado na variável 'number'
    }

    // Retorna o endereço do proprietário do contrato
    function getOwner() public view returns(address) {
        return owner; // Retorna o endereço do proprietário
    }

    // Retorna o saldo do contrato em Ether
    function getBalance() public view returns(uint256 bal) {
        bal = address(this).balance; // Armazena o saldo do contrato
    }
}