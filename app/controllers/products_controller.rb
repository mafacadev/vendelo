class ProductsController < ApplicationController
  # Muestra una lista de todos los productos activos.
  def index
    @products = Product.where(status: 1) # Filtra solo productos activos
  end

  # Muestra los detalles de un producto específico.
  def show
    @product = Product.find(params[:id])
  end

  # Renderiza el formulario para crear un nuevo producto.
  def new
    @product = Product.new
  end

  # Crea un nuevo producto con los parámetros proporcionados.
  # Si se guarda correctamente, redirige a la lista de productos.
  # Si no, renderiza el formulario de nuevo con errores.
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Renderiza el formulario para editar un producto existente.
  def edit
    @product = Product.find(params[:id])
  end

  # Actualiza un producto existente con los parámetros proporcionados.
  # Si se actualiza correctamente, redirige a la lista de productos.
  # Si no, renderiza el formulario de edición con errores.
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Realiza un borrado lógico de un producto existente y redirige a la lista de productos
  # con un mensaje de confirmación.
  def destroy
    @product = Product.find(params[:id])
    @product.update(status: 0) # Cambia el estado del producto a 0 (inactivo o eliminado)
    redirect_to products_path, notice: "Tu producto se ha marcado como eliminado correctamente", status: :see_other
  end

  private

  # Define los parámetros permitidos para crear o actualizar un producto.
  def product_params
    params.require(:product).permit(:title, :price, :description, :photo)
  end
end
