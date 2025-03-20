import hilog from '@ohos.hilog';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'

export default function abilityTest() {
  describe('ActsAbilityTest', function () {
    // 定义一个测试套件。支持两个参数:测试套件名称和测试套件功能
    beforeAll(function () {
      // 预设一个操作，该操作仅在测试套件的所有测试用例开始之前执行一次。
      // 这个API只支持一个参数:预置动作函数
    })
    beforeEach(function () {
      // 预设一个动作，在每个单元测试用例开始之前执行。
      // 执行次数与**it**定义的测试用例数量相同。
      // 这个API只支持一个参数:预置动作函数。
    })
    afterEach(function () {
      // 预设一个清除的动作，在每个单元测试用例结束后执行。
      // 执行次数与**it**定义的测试用例数量相同。
      // 这个API只支持一个参数:clear action function
    })
    afterAll(function () {
      // 预设一个清除的动作，在测试套件的所有测试用例结束后执行。
      // 这个API只支持一个参数:clear action function。
    })
    it('assertContain',0, function () {
      // 定义一个测试用例。这个API支持三个参数:测试用例名称、过滤器参数和测试用例功能。
      hilog.info(0x0000, 'testTag', '%{public}s', 'it begin');
      let a = 'abc'
      let b = 'b'
      // 定义各种断言方法，这些方法用于声明预期的布尔条件。
      expect(a).assertContain(b)
      expect(a).assertEqual(a)
    })
  })
}