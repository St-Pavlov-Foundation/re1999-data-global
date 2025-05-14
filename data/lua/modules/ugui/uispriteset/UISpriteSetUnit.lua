module("modules.ugui.uispriteset.UISpriteSetUnit", package.seeall)

local var_0_0 = class("UISpriteSetUnit")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._loader = nil
	arg_1_0._spriteSetAsset = nil
	arg_1_0._assetPath = arg_1_1
	arg_1_0._refImageList = {}
	arg_1_0._refCacheImages = {}
	arg_1_0._loading = false
	arg_1_0._loadDone = false
end

function var_0_0.getSpriteSetAsset(arg_2_0)
	return arg_2_0._spriteSetAsset
end

function var_0_0._checkLoadAsset(arg_3_0)
	if arg_3_0._loader then
		return
	end

	arg_3_0._loading = true

	local var_3_0 = MultiAbLoader.New()

	arg_3_0._loader = var_3_0

	var_3_0:addPath(arg_3_0._assetPath)
	var_3_0:startLoad(function(arg_4_0)
		local var_4_0 = var_3_0:getAssetItem(arg_3_0._assetPath):GetResource(arg_3_0._assetPath)

		arg_3_0._spriteSetAsset = var_4_0

		for iter_4_0, iter_4_1 in pairs(arg_3_0._refCacheImages) do
			local var_4_1 = iter_4_1.spriteName
			local var_4_2 = iter_4_1.setNativeSize
			local var_4_3 = iter_4_1.alpha

			if gohelper.isNil(iter_4_0) == false then
				arg_3_0:_setImgAlpha(iter_4_0, var_4_3 or 1)

				iter_4_0.sprite = arg_3_0._spriteSetAsset:GetSprite(var_4_1)

				if var_4_2 then
					iter_4_0:SetNativeSize()
				end

				table.insert(arg_3_0._refImageList, iter_4_0)
			end
		end

		arg_3_0._refCacheImages = {}
		arg_3_0._hasCache = false
		arg_3_0._loading = false
		arg_3_0._loadDone = true

		if arg_3_0.callback then
			arg_3_0.callback(arg_3_0.callbackObj)
		end
	end)
end

function var_0_0.setImageAlpha(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._refCacheImages[arg_5_1]

	if var_5_0 then
		var_5_0.alpha = arg_5_2
	else
		arg_5_0:_setImgAlpha(arg_5_1, arg_5_2)
	end
end

function var_0_0._setImgAlpha(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.color

	var_6_0.a = arg_6_2
	arg_6_1.color = var_6_0
end

function var_0_0.setSprite(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if gohelper.isNil(arg_7_1) then
		logError("set SpriteSet fail, image = null, spriteName = " .. (arg_7_2 or "nil"))

		return
	end

	if string.nilorempty(arg_7_2) then
		logError("set SpriteSet fail, spriteName = null, image = " .. (arg_7_1 and arg_7_1.name or "nil"))

		return
	end

	arg_7_0:_checkLoadAsset()

	if not arg_7_0._spriteSetAsset then
		if gohelper.isNil(arg_7_1.sprite) then
			arg_7_0:_setImgAlpha(arg_7_1, 0)
		end

		arg_7_0._refCacheImages[arg_7_1] = {
			spriteName = arg_7_2,
			setNativeSize = arg_7_3,
			alpha = arg_7_4
		}
		arg_7_0._hasCache = true

		return
	end

	if arg_7_2 then
		arg_7_1.sprite = arg_7_0._spriteSetAsset:GetSprite(arg_7_2)

		if arg_7_3 then
			arg_7_1:SetNativeSize()
		end
	end

	table.insert(arg_7_0._refImageList, arg_7_1)
end

function var_0_0.loadAsset(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._loadDone then
		arg_8_1(arg_8_2)

		return
	end

	arg_8_0.callback = arg_8_1
	arg_8_0.callbackObj = arg_8_2

	if arg_8_0._loading then
		return
	end

	arg_8_0._loading = true

	local var_8_0 = MultiAbLoader.New()

	arg_8_0._loader = var_8_0

	var_8_0:addPath(arg_8_0._assetPath)
	var_8_0:startLoad(function(arg_9_0)
		local var_9_0 = var_8_0:getAssetItem(arg_8_0._assetPath):GetResource(arg_8_0._assetPath)

		arg_8_0._spriteSetAsset = var_9_0
		arg_8_0._loading = false
		arg_8_0._loadDone = true

		if arg_8_0.callback then
			arg_8_0.callback(arg_8_0.callbackObj)
		end
	end)
end

function var_0_0.getSprite(arg_10_0, arg_10_1)
	if not arg_10_0._loadDone then
		logError("sprite not load done, please use self:loadAsset() load.")

		return nil
	end

	return arg_10_0._spriteSetAsset:GetSprite(arg_10_1)
end

function var_0_0.tryDispose(arg_11_0)
	if arg_11_0._hasCache then
		return
	end

	for iter_11_0 = #arg_11_0._refImageList, 1, -1 do
		local var_11_0 = arg_11_0._refImageList[iter_11_0]

		if gohelper.isNil(var_11_0) then
			table.remove(arg_11_0._refImageList, iter_11_0)
		end
	end

	if arg_11_0._loader and #arg_11_0._refImageList == 0 then
		arg_11_0._spriteSetAsset = nil

		arg_11_0._loader:dispose()

		arg_11_0._loader = nil
	end
end

return var_0_0
