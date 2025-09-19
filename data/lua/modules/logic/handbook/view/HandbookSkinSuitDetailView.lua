module("modules.logic.handbook.view.HandbookSkinSuitDetailView", package.seeall)

local var_0_0 = class("HandbookSkinSuitDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._skinItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_scroll/#go_storyStages")
	arg_1_0._textSkinThemeDescr = gohelper.findChildText(arg_1_0.viewGO, "#txt_Descr")
	arg_1_0._imageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.customAddEvent(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._skinItemList = arg_5_0:getUserDataTb_()

	arg_5_0:customAddEvent()

	arg_5_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_5_0.viewGO)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._skinThemeGroupId = arg_6_0.viewParam.skinThemeGroupId
	arg_6_0._skinThemeCfg = HandbookConfig.instance:getSkinSuitCfg(arg_6_0._skinThemeGroupId)

	local var_6_0 = arg_6_0._skinThemeCfg.skinContain

	arg_6_0._skinIdList = string.splitToNumber(var_6_0, "|")

	arg_6_0:_createSkinItems()
	arg_6_0:_refreshDesc()
	arg_6_0:_refreshBg()
end

function var_0_0.refreshUI(arg_7_0)
	return
end

function var_0_0.refreshBtnStatus(arg_8_0)
	return
end

function var_0_0._refreshDesc(arg_9_0)
	arg_9_0._textSkinThemeDescr.text = arg_9_0._skinThemeCfg.des
end

function var_0_0._refreshBg(arg_10_0)
	local var_10_0 = arg_10_0._skinThemeCfg.backImg

	if not string.nilorempty(var_10_0) then
		arg_10_0._imageBg:LoadImage(var_10_0)
	end
end

function var_0_0._createSkinItems(arg_11_0)
	local var_11_0 = string.split(arg_11_0._skinThemeCfg.skinOffset, "|")
	local var_11_1 = string.splitToNumber(arg_11_0._skinThemeCfg.frameImg, "|")
	local var_11_2 = string.split(arg_11_0._skinThemeCfg.spineParams, "|")
	local var_11_3 = arg_11_0.viewContainer:getSetting().otherRes[1]

	for iter_11_0 = 1, #arg_11_0._skinIdList do
		local var_11_4 = arg_11_0:getResInst(var_11_3, arg_11_0._skinItemRoot)
		local var_11_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_4, HandbookSkinItem, arg_11_0)

		var_11_5:refreshItem(arg_11_0._skinIdList[iter_11_0], var_11_0 and var_11_0[iter_11_0], var_11_1 and var_11_1[iter_11_0], var_11_2 and var_11_2[iter_11_0], iter_11_0)
		table.insert(arg_11_0._skinItemList, var_11_5)
	end

	local var_11_6 = arg_11_0._skinItemList[#arg_11_0._skinItemList]
	local var_11_7 = var_11_6.viewGO.transform.localPosition.x + var_11_6:getWidth()
	local var_11_8 = arg_11_0._skinItemRoot:GetComponent(typeof(UnityEngine.RectTransform))

	var_11_8.sizeDelta = Vector2(var_11_7, var_11_8.sizeDelta.y)
end

function var_0_0.onClose(arg_12_0)
	arg_12_0._imageBg:UnLoadImage()
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
