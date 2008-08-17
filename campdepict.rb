include Java

Camping.goes :Campdepict

module Campdepict::Controllers

  class Index < R '/'
    def get
      if input.smiles then
	@smiles = input.smiles
      else
	@smiles = ''
      end
      @escapedSmiles = CGI::escape(@smiles)
      render :smiles_picture
    end

  end

  class Image_for < R '/image_for'
    def get
      render_smiles(input.smiles)
    end  
  end

end

module Campdepict::Views
  def layout
    html do
      head do
	title { "SMILES Depictor" }
      end
      body { self << yield }
    end
  end

  def smiles_picture
    h1 "Depict a SMILES String"
    img :src=> "/image_for/?smiles=#{@escapedSmiles}"
    br
    form :action => R(Index), :method => 'get' do
      label 'Smiles', :for => 'smiles'
			 input :name => 'smiles', :value => @smiles, :size => "50", :type => 'text'
    end
    br
  end
end

module Campdepict::Helpers
    EDGE_SIZE = 200 # image size
    MIME_TYPES = {'.css' => 'text/css', '.js' => 'text/javascript', 
		'.jpg' => 'image/jpeg', '.png' => 'image/png'}
    PATH = Dir.pwd

    def render_smiles(smiles)
      if ! smiles || (smiles.eql? '') then
	return static_get('blank.png')
      end
      
      # cdk-20060714 dependent code
      begin
	smiles_parser = org.openscience.cdk.smiles.SmilesParser.new
	sdg = org.openscience.cdk.layout.StructureDiagramGenerator.new
        sdg.setMolecule( smiles_parser.parseSmiles( smiles ) )
        sdg.generateCoordinates
	image = Java::net.sf.structure.cdk.util.ImageKit.createRenderedImage(sdg.getMolecule(), EDGE_SIZE, EDGE_SIZE )
      rescue
	return static_get('invalid.png')
      end

      out = java.io.ByteArrayOutputStream.new
      javax.imageio.ImageIO.write image, "png", out

      String.from_java_bytes out.toByteArray
    end

    # static_get is straight outa the Camping wiki
    def static_get(path)
      @headers['Content-Type'] = MIME_TYPES[path[/\.\w+$/, 0]] || "text/plain"
      unless path.include? ".." # prevent directory traversal attacks
	@headers['X-Sendfile'] = "#{PATH}/static/#{path}"
      else
	@status = "403"
      "403 - Invalid path"
      end
   end
end
