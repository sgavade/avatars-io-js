class AIOUploader
	@token: ''
	currentShortcut: ''
	
	constructor: (@selector, @callback) ->
		@uploader = new AjaxUpload $(@selector)[0],
			action: "http://chute.com:3000/v1/upload?shortcut=#{ @currentShortcut }&authorization=#{ AIOUploader.token }"
			name: 'avatar'
			allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']
			onSubmit: =>
				@currentShortcut = @shortcut()
				@uploader._settings.action = "http://chute.com:3000/v1/upload?shortcut=#{ @currentShortcut }&authorization=#{ AIOUploader.token }"
			
			onComplete: => @callback false, "http://chute.com:3000/#{ @currentShortcut }"
	
	shortcut: ->
		value = 'u'
		possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

		loop
			break if value.length is 10
			value += possible.charAt(Math.floor(Math.random() * possible.length))

		value