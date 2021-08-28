Rails.application.routes.draw do
  mount Vocab::Engine => "/vocab"
end
