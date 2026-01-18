Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do para incluir formato JSON padrã para incluir formato JSON padrãoo
      # Here we will put all our API routes
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
