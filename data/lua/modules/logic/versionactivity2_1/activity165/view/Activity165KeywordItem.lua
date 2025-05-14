module("modules.logic.versionactivity2_1.activity165.view.Activity165KeywordItem", package.seeall)

local var_0_0 = class("Activity165KeywordItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtkeywords = gohelper.findChildText(arg_1_0.viewGO, "#txt_keywords")
	arg_1_0._btnkeywords = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_keywords")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnkeywords:AddClickListener(arg_2_0._btnkeywordsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnkeywords:RemoveClickListener()
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEvents()
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0:removeEvents()
	arg_5_0:_removeEventListeners()
end

function var_0_0._btnclickOnClick(arg_6_0)
	return
end

function var_0_0._btnkeywordsOnClick(arg_7_0)
	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickUsedKeyword, arg_7_0._mo.keywordId)
	arg_7_0:onRefresh()
end

function var_0_0._btnkewordsOnClick(arg_8_0)
	return
end

function var_0_0._removeEventListeners(arg_9_0)
	if arg_9_0.drag then
		arg_9_0.drag:RemoveDragBeginListener()
		arg_9_0.drag:RemoveDragListener()
		arg_9_0.drag:RemoveDragEndListener()
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._canvasgroup = arg_10_0.viewGO:GetComponent(gohelper.Type_CanvasGroup)
end

function var_0_0.init(arg_11_0, arg_11_1)
	arg_11_0.viewGO = arg_11_1

	gohelper.setActive(arg_11_1, true)
	arg_11_0:onInitView()
end

function var_0_0.setDragEvent(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0._mo then
		arg_12_0.drag = SLFramework.UGUI.UIDragListener.Get(arg_12_0._btnkeywords.gameObject)

		arg_12_0.drag:AddDragBeginListener(arg_12_1, arg_12_4, arg_12_0._mo.keywordId)
		arg_12_0.drag:AddDragListener(arg_12_2, arg_12_4)
		arg_12_0.drag:AddDragEndListener(arg_12_3, arg_12_4)
	end
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._mo = arg_13_1

	if arg_13_1 then
		arg_13_0._txtkeywords.text = arg_13_1.keywordCo.text

		local var_13_0 = arg_13_1.keywordCo.pic

		if not string.nilorempty(var_13_0) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(arg_13_0._imageicon, var_13_0)
		end
	end
end

function var_0_0.onRefresh(arg_14_0)
	if arg_14_0._mo.isUsed then
		arg_14_0:Using()
	else
		arg_14_0:clearUsing()
	end
end

function var_0_0.Using(arg_15_0)
	arg_15_0:_setAlpha(0.5)
end

function var_0_0.clearUsing(arg_16_0)
	arg_16_0:_setAlpha(1)
end

function var_0_0._setAlpha(arg_17_0, arg_17_1)
	if arg_17_0._canvasgroup then
		arg_17_0._canvasgroup.alpha = arg_17_1
	end
end

return var_0_0
