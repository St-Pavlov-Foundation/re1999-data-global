module("modules.logic.character.config.SkinConfig", package.seeall)

local var_0_0 = class("SkinConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._skinConfig = nil
	arg_1_0._skinStoreTagConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"skin",
		"skin_special_act",
		"skin_ui_effect",
		"skin_ui_bloom",
		"skin_monster_scale",
		"skin_monster_hide_buff_effect",
		"skin_store_tag",
		"skin_fullscreen_effect"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "skin" then
		arg_3_0._skinConfig = arg_3_2

		arg_3_0:_initSkinConfig()
	elseif arg_3_1 == "skin_store_tag" then
		arg_3_0._skinStoreTagConfig = arg_3_2
	end
end

function var_0_0._initSkinConfig(arg_4_0)
	if not arg_4_0._characterSkinCoList then
		arg_4_0._characterSkinCoList = {}
		arg_4_0._live2dSkinDic = {}
		arg_4_0._skinFolderNameMap = {}
		arg_4_0._skinStoreGoodsDict = {}

		local var_4_0 = arg_4_0._skinConfig.configList

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if not string.nilorempty(iter_4_1.live2d) and not string.nilorempty(iter_4_1.verticalDrawing) then
				arg_4_0._live2dSkinDic[iter_4_1.verticalDrawing] = iter_4_1.live2d
			end

			if not string.nilorempty(iter_4_1.folderName) then
				if not string.nilorempty(iter_4_1.live2d) then
					arg_4_0:_setFolderName(iter_4_1.live2d, iter_4_1.folderName)
				elseif not string.nilorempty(iter_4_1.verticalDrawing) then
					arg_4_0:_setFolderName(iter_4_1.verticalDrawing, iter_4_1.folderName)
				end
			end

			local var_4_1 = arg_4_0._characterSkinCoList[iter_4_1.characterId]

			if not var_4_1 then
				var_4_1 = {}
				arg_4_0._characterSkinCoList[iter_4_1.characterId] = var_4_1
			end

			table.insert(var_4_1, iter_4_1)

			if iter_4_1.skinStoreId ~= 0 then
				arg_4_0._skinStoreGoodsDict[iter_4_1.skinStoreId] = iter_4_1.id
			end
		end
	end
end

function var_0_0.isSkinStoreGoods(arg_5_0, arg_5_1)
	if arg_5_0._skinStoreGoodsDict then
		return arg_5_0._skinStoreGoodsDict[arg_5_1] ~= nil, arg_5_0._skinStoreGoodsDict[arg_5_1]
	end
end

function var_0_0._setFolderName(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:_checkFolderName(arg_6_1)

	arg_6_0._skinFolderNameMap[arg_6_1] = arg_6_2

	if not string.match(arg_6_2, "v%d+a%d+_") then
		logError(string.format("SkinConfig folderName:%s 不符合版本格式", arg_6_2))
	end
end

function var_0_0._checkFolderName(arg_7_0, arg_7_1)
	if arg_7_0._skinFolderNameMap[arg_7_1] then
		logError(string.format("SkinConfig repeat folderName:%s,resName:%s", arg_7_0._skinFolderNameMap[arg_7_1], arg_7_1))
	end
end

function var_0_0.getFolderName(arg_8_0, arg_8_1)
	return arg_8_0._skinFolderNameMap[arg_8_1] or arg_8_1
end

function var_0_0.getLive2dSkin(arg_9_0, arg_9_1)
	return arg_9_0._live2dSkinDic[arg_9_1]
end

function var_0_0.getSkinCo(arg_10_0, arg_10_1)
	return arg_10_0._skinConfig.configDict[arg_10_1]
end

function var_0_0.getAllSkinCoList(arg_11_0)
	return arg_11_0._skinConfig.configList
end

function var_0_0.getSkinOffset(arg_12_0, arg_12_1, arg_12_2)
	if string.nilorempty(arg_12_1) then
		if arg_12_2 then
			return arg_12_2, true
		end

		return {
			0,
			0,
			1
		}, true
	end

	return string.splitToNumber(arg_12_1, "#"), false
end

function var_0_0.getAfterRelativeOffset(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = CommonConfig.instance:getConstStr(arg_13_1)
	local var_13_1, var_13_2 = arg_13_0:getSkinOffset(var_13_0)

	if var_13_2 then
		return arg_13_2
	end

	arg_13_2[1] = arg_13_2[1] + var_13_1[1]
	arg_13_2[2] = arg_13_2[2] + var_13_1[2]
	arg_13_2[3] = arg_13_2[3] + var_13_1[3]

	return arg_13_2
end

function var_0_0.getCharacterSkinCoList(arg_14_0, arg_14_1)
	return arg_14_0._characterSkinCoList[arg_14_1]
end

function var_0_0.getSkinStoreTagConfig(arg_15_0, arg_15_1)
	return arg_15_0._skinStoreTagConfig.configDict[arg_15_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
