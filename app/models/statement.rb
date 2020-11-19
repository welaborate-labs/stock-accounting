class Statement < ApplicationRecord
  belongs_to :statement_file
  belongs_to :brokerage_account
  has_many :trades, dependent: :destroy

  # note_number     = page.text.match('\d{6}').to_s
  #     date            = page.text.match('\d{1,2}\/\d{1,2}\/\d{4}').to_s
  #     client_number   = page.text.match('\d{7}\-?\d{1}').to_s
  #     cnpj            = page.text.match('\d{2}\.?\d{3}\.?\d{3}\/\d{4}\-?\d{2}').to_s
  #     cpf             = page.text.match('\d{3}\.?\d{3}\.?\d{3}\-?\d{2}').to_s
  #     content         = page.text

  # if cpf.present?
  #   cnpj_or_cpf = cpf
  # else
  #   cnpj_or_cpf = cnpj[2]
  # end

  # # TODO make mechanism to set the right brokerage
  # brokerage = BrokerageAccount.find_by(brokerage: 1)
  # unless brokerage do
  #   brokerage = BrokerageAccount.create(account_id: Account.last.id,
  #                           brokerage: note_number,
  #                           number: client_number,
  #                           account_number: cnpj_or_cpf)
  # end

  # if note_number.present?
  #   if brokerage.present?
  #     statement = Statement.find_by(statement_date: date)
  #     statement.content << content
  #     statement.save!
  #   else
  #     # TODO Account.last
  #     Statement.create(statement_date: date,
  #                       statement_file_id: statement_file.id,
  #                       brokerage_account_id: BrokerageAccount.last.id,
  #                       content: content)
  #   end
  # end
end
