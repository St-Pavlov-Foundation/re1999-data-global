module("modules.logic.notice.view.NoticeTitleItem", package.seeall)

local var_0_0 = class("NoticeTitleItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._click = gohelper.getClickWithAudio(arg_1_1, AudioEnum.UI.UI_Common_Click)
	arg_1_0._redtipGO = gohelper.findChild(arg_1_1, "#go_redtip")
	arg_1_0._normalGO = gohelper.findChild(arg_1_1, "#go_normal")
	arg_1_0._selectGO = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._txtTitle1 = gohelper.findChildText(arg_1_0._normalGO, "title")
	arg_1_0._txtTitle2 = gohelper.findChildText(arg_1_0._selectGO, "title")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickItem, arg_2_0)
	arg_2_0._click:AddClickDownListener(arg_2_0._onClickItemDown, arg_2_0)
	arg_2_0._click:AddClickUpListener(arg_2_0._onClickItemUp, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._click:RemoveClickUpListener()
	arg_3_0._click:RemoveClickDownListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._txtTitle1.text = arg_4_1:getTitle()
	arg_4_0._txtTitle2.text = arg_4_1:getTitle()

	gohelper.setActive(arg_4_0._redtipGO, not NoticeModel.instance:getNoticeMoIsRead(arg_4_0._mo))
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	if arg_5_1 then
		gohelper.setActive(arg_5_0._redtipGO, false)
		NoticeModel.instance:readNoticeMo(arg_5_0._mo)
		NoticeController.instance:dispatchEvent(NoticeEvent.OnSelectNoticeItem, arg_5_0._mo)
	end

	gohelper.setActive(arg_5_0._selectGO, arg_5_1)
	gohelper.setActive(arg_5_0._normalGO, not arg_5_1)
end

function var_0_0._onClickItem(arg_6_0)
	local var_6_0 = NoticeModel.instance:getIndex(arg_6_0._mo)

	if var_6_0 == arg_6_0._view.lastSelectIndex then
		return
	end

	arg_6_0._view:selectCell(var_6_0, true)

	arg_6_0._view.lastSelectIndex = var_6_0

	local var_6_1 = ViewMgr.instance:getContainer(ViewName.NoticeView)

	if var_6_1 then
		var_6_1:trackNoticeLoad(arg_6_0._mo)
	end
end

function var_0_0._onClickItemDown(arg_7_0)
	arg_7_0:_setItemPressState(true)
end

function var_0_0._onClickItemUp(arg_8_0)
	arg_8_0:_setItemPressState(false)
end

function var_0_0._setItemPressState(arg_9_0, arg_9_1)
	if not arg_9_0._itemContainer then
		arg_9_0._itemContainer = arg_9_0:getUserDataTb_()

		local var_9_0 = arg_9_0._go:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_9_0._itemContainer.images = var_9_0

		local var_9_1 = arg_9_0._go:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_9_0._itemContainer.tmps = var_9_1
		arg_9_0._itemContainer.compColor = {}

		local var_9_2 = var_9_0:GetEnumerator()

		while var_9_2:MoveNext() do
			arg_9_0._itemContainer.compColor[var_9_2.Current] = var_9_2.Current.color
		end

		local var_9_3 = var_9_1:GetEnumerator()

		while var_9_3:MoveNext() do
			arg_9_0._itemContainer.compColor[var_9_3.Current] = var_9_3.Current.color
		end
	end

	if arg_9_0._itemContainer then
		UIColorHelper.setUIPressState(arg_9_0._itemContainer.images, arg_9_0._itemContainer.compColor, arg_9_1)
		UIColorHelper.setUIPressState(arg_9_0._itemContainer.tmps, arg_9_0._itemContainer.compColor, arg_9_1)
	end
end

return var_0_0
