package com.yi.handler.bankwork.card;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yi.dto.BankBook;
import com.yi.dto.Card;
import com.yi.dto.Customer;
import com.yi.mvc.CommandHandler;
import com.yi.service.BankBookService;
import com.yi.service.CardService;

public class DetailHandler implements CommandHandler {
	private CardService service = new CardService();
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String cardNum = req.getParameter("cardnum");
		String custName = req.getParameter("custname");
		Card card = new Card();
		card.setCardNum(cardNum);
		Customer customer = new Customer();
		customer.setCustName(custName);
		card.setCustCode(customer);
		card = service.showCardByCardNumAndCustName(card);
		req.setAttribute("card", card);
		return "/WEB-INF/view/bankwork/card/cardDetail.jsp";
	}

}
