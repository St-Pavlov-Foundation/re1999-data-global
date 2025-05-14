module("modules.logic.rouge.view.RougeIllustrationDetailView", package.seeall)

local var_0_0 = class("RougeIllustrationDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageFrameBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FrameBG")
	arg_1_0._simageBottomBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Bottom/#simage_BottomBG")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#txt_Name")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#txt_Descr")
	arg_1_0._txtPage = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#txt_Page")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0._goLeftTop = gohelper.findChild(arg_1_0.viewGO, "#go_LeftTop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
end

function var_0_0._btnLeftOnClick(arg_4_0)
	arg_4_0._index = arg_4_0._index - 1

	if arg_4_0._index < 1 then
		arg_4_0._index = arg_4_0._num
	end

	arg_4_0:_changePage()
end

function var_0_0._btnRightOnClick(arg_5_0)
	arg_5_0._index = arg_5_0._index + 1

	if arg_5_0._index > arg_5_0._num then
		arg_5_0._index = 1
	end

	arg_5_0:_changePage()
end

function var_0_0._changePage(arg_6_0)
	arg_6_0._aniamtor:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(arg_6_0._delayUpdateInfo, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._delayUpdateInfo, arg_6_0, 0.3)
end

function var_0_0._delayUpdateInfo(arg_7_0)
	arg_7_0:_updateInfo(arg_7_0._list[arg_7_0._index])
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txtNameEn = gohelper.findChildText(arg_8_0.viewGO, "Bottom/#txt_Name/txt_NameEn")
	arg_8_0._aniamtor = gohelper.onceAddComponent(arg_8_0.viewGO, gohelper.Type_Animator)
end

function var_0_0._initIllustrationList(arg_9_0)
	local var_9_0 = RougeFavoriteConfig.instance:getIllustrationList()

	arg_9_0._list = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if RougeOutsideModel.instance:passedAnyEventId(iter_9_1.eventIdList) then
			table.insert(arg_9_0._list, iter_9_1.config)
		end
	end

	arg_9_0._num = #arg_9_0._list
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_initIllustrationList()

	local var_10_0 = arg_10_0.viewParam

	arg_10_0._index = tabletool.indexOf(arg_10_0._list, var_10_0) or 1

	arg_10_0:_updateInfo(var_10_0)
end

function var_0_0._updateInfo(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1
	arg_11_0._txtName.text = arg_11_0._mo.name
	arg_11_0._txtNameEn.text = arg_11_0._mo.nameEn
	arg_11_0._txtDescr.text = arg_11_0._mo.desc
	arg_11_0._txtPage.text = string.format("%s/%s", arg_11_0._index, arg_11_0._num)

	if not string.nilorempty(arg_11_0._mo.fullImage) then
		arg_11_0._simageFullBG:LoadImage(arg_11_0._mo.fullImage)
	end

	if RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Illustration, arg_11_0._mo.id) ~= nil then
		local var_11_0 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_11_0, RougeEnum.FavoriteType.Illustration, arg_11_0._mo.id)
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._delayUpdateInfo, arg_13_0)
end

return var_0_0
