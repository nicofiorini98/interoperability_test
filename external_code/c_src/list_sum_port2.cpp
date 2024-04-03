#include <iostream>
#include <string>
#include <vector>

int main(int argc, char* argv[]) {
    if (argc < 1) {
        std::cerr << "Usage: " << argv[0] << " <num1> <num2> ..." << std::endl;
        return 1;
    }

    std::vector<long> numbers;
    std::vector<long> results;
    for (int i = 1; i < argc; ++i) {
        numbers.push_back(std::stol(argv[i]));
    }

	for(auto& num: numbers){
		long sum = 0;
		for(int i=0;i <= num; i++){
			sum += i;
		}
		results.push_back(sum);
	}


	for(int i=0; i < results.size()-1 ; i++){
		std::cout<<results[i]<<",";
	}
	std::cout<<results[results.size()-1]<<std::endl;

    return 0;
}