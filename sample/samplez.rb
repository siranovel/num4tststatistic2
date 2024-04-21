require 'num4tststatistic2'
require 'num4hypothtst'
require_relative('mymatcher')

RSpec.describe Num4TstStatistic2Lib do
    let!(:a) { 0.05 }
    describe Num4TstStatistic2Lib::ParametrixTestLib do
        let!(:hypothTest2) { Num4HypothTestLib::TwoSideTestLib.new }
        let!(:hypothTestR) { Num4HypothTestLib::RightSideTestLib.new }
        let!(:hypothTestL) { Num4HypothTestLib::LeftSideTestLib.new }
        let(:paraTest2) { Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTest2) }
        let(:paraTestL) { Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTestL) }
        let(:paraTestR) { Num4TstStatistic2Lib::ParametrixTestLib.new(hypothTestR) }

        it '#populationMean' do
            xi = [15.5, 15.7, 15.4, 15.4, 15.6, 15.4, 15.6, 15.5, 15.4]
            expect(
                paraTest2.populationMean(xi, 15.4, a)
            ).to eq true
        end
        it '#populationVar' do
            xi = [35.2, 34.5, 34.9, 35.2, 34.8, 35.1, 34.9, 35.2, 34.9, 34.8]
            sd = 0.4
            expect(
                paraTestL.populationVar(xi, sd * sd, a)
            ).to eq true
        end
        it '#populationRatio' do
            expect(
                paraTestL.populationRatio(29, 346, 0.12, a)
            ).to eq true
        end
        it '#diffPopulationMean2EquVar' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest2.diffPopulationMean2EquVar(xi1, xi2, a)
            ).to eq false
        end
        it '#diffPopulationMean2UnEquVar' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest2.diffPopulationMean2UnEquVar(xi1, xi2, a)
            ).to eq false
        end
        it '#diffPopulationMean' do
            xi1 = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
            xi2 = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
            expect(
                paraTestR.diffPopulationMean(xi1, xi2, a)
            ).to eq true
        end
        it '#diffPopulationVar' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest2.diffPopulationVar(xi1, xi2, a)
            ).to eq false
        end
        it '#diffPopulationRatio' do
            expect(
                paraTest2.diffPopulationRatio(469, 1200, 308, 900, a)
            ).to eq true
        end
        it '#fidelity' do
            fi = [57, 33, 46, 14]
            pi = [0.4, 0.2, 0.3, 0.1]
            expect(
                paraTestR.fidelity(fi, pi, a)
            ).to eq false
        end
        it '#independency' do
            fij = [
               [57, 33, 46, 14],
               [89, 24, 75, 12],
            ]
            expect(
                paraTestR.independency(fij, a)
            ).to eq true
        end
    end
    describe Num4TstStatistic2Lib::NonParametrixTestLib do
        let!(:hypothTest2) { Num4HypothTestLib::TwoSideTestLib.new }
        let!(:nonParaTest) { Num4TstStatistic2Lib::NonParametrixTestLib.new(hypothTest2) }
        it '#utest' do
            x = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            y = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                nonParaTest.utest(x, y, a)
            ).to eq false
        end
        it '#wilcoxon' do
            x = [37.1, 36.2, 36.6, 37.4, 36.8, 36.7, 36.9, 37.4, 36.6, 36.7]
            y = [36.8, 36.6, 36.5, 37.0, 36.0, 36.5, 36.6, 37.1, 36.4, 36.7]
            expect(
                nonParaTest.wilcoxon(x, y, a)
            ).to eq false
        end
        it '#ks2test' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                nonParaTest.ks2test(xi1, xi2, 0.05)
            ).to eq false
        end
    end
    describe Num4TstStatistic2Lib::OutlierLib do
        let!(:outlier) { Num4TstStatistic2Lib::OutlierLib.new }
        it '#grubbs' do
            xi = [3.4, 3.5, 3.3, 2.2, 3.3, 3.4, 3.6, 3.2]
            expect(
                outlier.grubbs(xi, 2.2, a)
            ).to eq true
        end
        it '#errbar' do
            xi = [3.4, 3.5, 3.3, 2.2, 3.3, 3.4, 3.6, 3.2]
            expect(
                outlier.errbar("LDH", xi)
            ).to is_exist("errbar.jpeg")
        end
    end
    describe Num4TstStatistic2Lib::DecorrTestLib do
        let(:paraTest) { Num4TstStatistic2Lib::DecorrTestLib.new }
        
        it '#pearsoCorrelation' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                paraTest.pearsoCorrelation(x, y, a)
            ).to eq true
        end
        it '#spearmanscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                paraTest.spearmanscorr(x, y, a)
            ).to eq true
        end
        it '#kendallscorr' do
            x = [113, 64, 16, 45, 28, 19, 30, 82, 76]
            y = [31, 5, 2, 17, 18, 2, 9, 25, 13]
            expect(
                paraTest.kendallscorr(x, y, a)
            ).to eq false
        end
    end
end

