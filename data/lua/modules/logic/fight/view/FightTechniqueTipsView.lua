module("modules.logic.fight.view.FightTechniqueTipsView", package.seeall)

local var_0_0 = class("FightTechniqueTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goclose = gohelper.findChildClick(arg_1_0.viewGO, "#go_close")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "#go_center")
	arg_1_0._txttemp = gohelper.findChildText(arg_1_0.viewGO, "#txt_temp")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/#simage_icon")
	arg_1_0._mask = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._goclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._mask:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._goclose:RemoveClickListener()
	arg_3_0._mask:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshView()
end

function var_0_0._refreshView(arg_8_0)
	if arg_8_0.viewParam.isGMShow then
		arg_8_0.config = arg_8_0.viewParam.config
	else
		arg_8_0.config = arg_8_0.viewParam

		FightViewTechniqueModel.instance:readTechnique(arg_8_0.config.id)
	end

	arg_8_0._simageicon:LoadImage(ResUrl.getTechniqueLangIcon(arg_8_0.config.picture2 or ""))

	local var_8_0 = FightStrUtil.instance:getSplitCache(arg_8_0.config.content1, "|")

	for iter_8_0, iter_8_1 in pairs(lua_fight_technique.configDict) do
		local var_8_1 = gohelper.findChild(arg_8_0.viewGO, "#go_center/content/" .. iter_8_1.id)

		if var_8_1 then
			gohelper.setActive(var_8_1, iter_8_1.id == arg_8_0.config.id)

			if arg_8_0.config.id == iter_8_1.id then
				for iter_8_2, iter_8_3 in ipairs(var_8_0) do
					iter_8_3 = string.gsub(iter_8_3, "%{", string.format("<color=%s>", "#ff906a"))
					iter_8_3 = string.gsub(iter_8_3, "%}", "</color>")

					local var_8_2 = var_8_1:GetComponentsInChildren(gohelper.Type_TextMesh)

					for iter_8_4 = 0, var_8_2.Length - 1 do
						if var_8_2[iter_8_4].gameObject.name == "txt_" .. iter_8_2 then
							var_8_2[iter_8_4].text = iter_8_3
						end
					end
				end
			end
		end
	end

	FightAudioMgr.instance:obscureBgm(true)
end

function var_0_0.onClose(arg_9_0)
	FightAudioMgr.instance:obscureBgm(false)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageicon:UnLoadImage()
end

return var_0_0
