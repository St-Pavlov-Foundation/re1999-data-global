module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandView", package.seeall)

local var_0_0 = class("VersionActivity1_3FairyLandView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_bg")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_bg2")
	arg_1_0._imagetitle = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_title")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_confirm")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/#go_content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	if not arg_4_0._useDreamCard then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3SelectedDreamCard), arg_4_0._selectedItem.config.id)
	end

	if arg_4_0._selectedItem then
		Activity126Controller.instance:dispatchEvent(Activity126Event.selectDreamLandCard, arg_4_0._selectedItem.config)
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getFairyLandIcon("v1a3_fairyland_bg"))
	arg_5_0._simagebg2:LoadImage(ResUrl.getFairyLandIcon("v1a3_fairyland_bg2"))
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_seek_open)
end

function var_0_0._initItems(arg_6_0)
	arg_6_0._itemList = arg_6_0:getUserDataTb_()

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[1]

	for iter_6_0, iter_6_1 in ipairs(lua_activity126_dreamland_card.configList) do
		if arg_6_0:_hasDreamCard(iter_6_1.id) then
			local var_6_1 = arg_6_0:getResInst(var_6_0, arg_6_0._gocontent)
			local var_6_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, VersionActivity1_3FairyLandItem, {
				arg_6_0,
				iter_6_1
			})

			table.insert(arg_6_0._itemList, var_6_2)
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._itemList) do
		if iter_6_3.config == arg_6_0._cardConfig then
			arg_6_0:landItemClick(iter_6_3)

			break
		end
	end
end

function var_0_0._hasDreamCard(arg_7_0, arg_7_1)
	if arg_7_0._taskConfig and arg_7_0._useDreamCard then
		return string.find(arg_7_0._taskConfig.dreamCards, arg_7_1)
	end

	return Activity126Model.instance:hasDreamCard(arg_7_1)
end

function var_0_0.landItemClick(arg_8_0, arg_8_1)
	arg_8_0._selectedItem = arg_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._itemList) do
		iter_8_1:setSelected(iter_8_1 == arg_8_1)
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._taskConfig = arg_10_0.viewParam[1]
	arg_10_0._cardConfig = arg_10_0.viewParam[2]
	arg_10_0._useDreamCard = not string.nilorempty(arg_10_0._taskConfig.dreamCards)

	arg_10_0:_initItems()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simagebg2:UnLoadImage()
end

return var_0_0
