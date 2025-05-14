// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Owner
 * @dev Contrato de Gestão de Propriedade com Eventos
 *
 * Conceitos importantes demonstrados:
 * 1. Eventos: Logging na blockchain para rastreabilidade
 * 2. Privacidade de Dados: Variáveis private vs public
 * 3. Padrão de Propriedade: Implementação de ownership
 * 4. Modificadores: Controle de acesso reutilizável
 * 5. Zero Address: Validações de segurança
 */
contract Owner {
    // Variável private: Acessível apenas dentro do contrato
    // Economia de gas comparado a public
    address private owner;

    /**
     * @dev Evento de Mudança de Propriedade
     * 
     * Conceitos demonstrados:
     * - Eventos como logs na blockchain
     * - Indexed parameters para filtragem
     * - Transparência de mudanças
     */
    event OwnerSet(
        address indexed oldOwner,  // Indexado para busca eficiente
        address indexed newOwner   // Indexado para busca eficiente
    );

    /**
     * @dev Modificador de Controle de Acesso
     * 
     * Conceitos demonstrados:
     * - Reusabilidade de código
     * - Validação de permissões
     * - Padrão de segurança
     */
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;  // Continuação do fluxo de execução
    }

    /**
     * @dev Constructor: Estabelece Propriedade Inicial
     * 
     * Conceitos demonstrados:
     * - Inicialização de contrato
     * - Emissão de eventos
     * - Endereço zero como valor especial
     */
    constructor() {
        owner = msg.sender;  // Atribuição inicial de propriedade
        // Evento com endereço zero como oldOwner indica criação
        emit OwnerSet(address(0), owner);
    }

    /**
     * @dev Transferência de Propriedade
     * 
     * Conceitos demonstrados:
     * - Validação de endereço
     * - Emissão de eventos
     * - Padrão de mudança de controle
     * @param newOwner endereço do novo proprietário
     */
    function changeOwner(address newOwner) public isOwner {
        // Validação contra endereço zero (prática de segurança)
        require(newOwner != address(0), "New owner should not be the zero address");
        
        // Armazena o proprietário atual para o evento
        address oldOwner = owner;
        
        // Atualiza o proprietário
        owner = newOwner;
        
        // Emite evento para registro na blockchain
        emit OwnerSet(oldOwner, newOwner);
    }

    /**
     * @dev Consulta de Proprietário
     * 
     * Conceitos demonstrados:
     * - Função external vs public
     * - View functions
     * - Acesso a dados private
     * @return endereço do proprietário atual
     */
    function getOwner() external view returns (address) {
        return owner;  // Acesso permitido a dados private através de função
    }
} 
