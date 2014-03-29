//
//  BinarySearch.cpp
//  
//
//  Created by Weinan Li on 12/8/13.
//
//

#include "BinarySearch.h"
#include <iostream>
#include <vector>

using namespace std;

class ordArray {
private:
    vector<double> v;
    int nElems;
public:
    ordArray(int max) {
        v.resize(max);
        nElems = 0;
    }
};