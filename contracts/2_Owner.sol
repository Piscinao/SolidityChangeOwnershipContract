// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Owner
 * @dev Define e altera o proprietário do contrato
 */
contract Owner {

    address private owner; // Armazena o endereço do proprietário

    // Evento para registro no EVM
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // Modificador para verificar se o chamador é o proprietário
    modifier isOwner() {
        // Verifica se o remetente da chamada é o proprietário
        require(msg.sender == owner, "Caller is not owner");
        _; // Continua a execução da função
    }

    /**
     * @dev Define o criador do contrato como proprietário
     */
    constructor() {
        owner = msg.sender; // 'msg.sender' é o remetente da chamada atual, que é o criador do contrato
        emit OwnerSet(address(0), owner); // Emite um evento informando que o proprietário foi definido
    }

    /**
     * @dev Altera o proprietário
     * @param newOwner endereço do novo proprietário
     */
    function changeOwner(address newOwner) public isOwner {
        require(newOwner != address(0), "New owner should not be the zero address"); // Verifica se o novo proprietário não é o endereço zero
        emit OwnerSet(owner, newOwner); // Emite um evento informando a mudança de proprietário
        owner = newOwner; // Atualiza o proprietário
    }

    /**
     * @dev Retorna o endereço do proprietário 
     * @return endereço do proprietário
     */
    function getOwner() external view returns (address) {
        return owner; // Retorna o endereço do proprietário
    }
} 
